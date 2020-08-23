import 'dart:io';

import 'package:chatIt/model/messages.dart';
import 'package:chatIt/services/authenticationServices.dart';
import 'package:chatIt/services/firestoreServices.dart';
import 'package:chatIt/services/navigatorServices.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../locator.dart';

class ChatScreenViewmodel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  final _firestoreService = locator<FireStoreServices>();

  String _groupId;

  String get groupId => _groupId;

  changeId(String text) {
    _groupId = text;
    notifyListeners();
  }

  currentUser() {
    return _authenticationService.currentUser.email;
  }

  void onSendMessage(String content, int type) {
    if (content.trim() != '') {
      _firestoreService.chatMesaages(
          groupId,
          Message(
            senderId: _authenticationService.currentUser.email,
            content: content,
            type: type,
            time: DateFormat('kk:mm:ss').format(DateTime.now()),
            timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
          ));
      // listScrollController.animateTo(0.0,
      //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send',
          backgroundColor: Colors.red,
          textColor: Colors.black);
    }
  }

  sendMessages(String text) {
    if (text.length > 1) {
      return onSendMessage(text, 0);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  chatSnapshots(String chatId) {
    return _firestoreService.chatSnapshots(chatId);
  }

  Future getImage() async {
    var picked = ImagePicker();
    var pickedFile = await picked.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setBusy(true);
      var imageFile = File(pickedFile.path);
      uploadFile(imageFile);
    }
  }

  Future uploadFile(dynamic imageFile) async {
    String fileName =
        '$groupId/${DateTime.now().millisecondsSinceEpoch.toString()}';
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    await storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      var imageUrl = downloadUrl;

      setBusy(false);
      onSendMessage(imageUrl, 1);
    }, onError: (err) {
      setBusy(false);
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }
}
