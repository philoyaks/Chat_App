import 'dart:io';

import 'package:chatIt/constants.dart';
import 'package:chatIt/model/user.dart';
import 'package:chatIt/services/authenticationServices.dart';
import 'package:chatIt/services/firestoreServices.dart';
import 'package:chatIt/services/navigatorServices.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import '../locator.dart';

class HomeViewModel extends BaseViewModel {
  final authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FireStoreServices>();

  Users users;

  String _groupchatName;
  String get groupChatId => _groupchatName;

  Users get currentusers => users;

  Stream get fetchFriends =>
      _firestoreService.friendlist(authenticationService.currentUser.email);

  checkCurrentUser() async {
    await authenticationService.isUserLoggedIn();
    if (authenticationService.currentUser.email == null) {
      Fluttertoast.showToast(
          msg: authenticationService.currentUser.toString(),
          backgroundColor: Colors.blue);
    }
    users = authenticationService.currentUser;
    notifyListeners();
  }

  fetchFriendSnapshot() {
    return _firestoreService.friendlist(currentusers.email);
  }

  fetchUnacceptedRequest() {
    _firestoreService
        .unacceptedFriendRequest(authenticationService.currentUser.email);
  }

  openChatScreen(Users peer) async {
    try {
      if (authenticationService.currentUser.email.hashCode <=
          peer.email.hashCode) {
        _groupchatName =
            '${authenticationService.currentUser.email}-${peer.email}';
        await _navigationService
            .navigateTo(ChatViewRoute, arguments: [_groupchatName, peer]);
      } else {
        _groupchatName =
            '${peer.email}-${authenticationService.currentUser.email}';
        await _navigationService
            .navigateTo(ChatViewRoute, arguments: [_groupchatName, peer]);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  lastMessages(Users peer) {
    try {
      if (authenticationService.currentUser.email.hashCode <=
          peer.email.hashCode) {
        _groupchatName =
            '${authenticationService.currentUser.email}-${peer.email}';
        return _firestoreService.chatSnapshots(_groupchatName);
      } else {
        _groupchatName =
            '${peer.email}-${authenticationService.currentUser.email}';
        return _firestoreService.chatSnapshots(_groupchatName);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  upDateProfile(File imageFile) async {
    setBusy(true);
    if (imageFile != null) {
      String fileName =
          '${authenticationService.currentUser.email}/${DateTime.now().millisecondsSinceEpoch.toString()}';
      StorageReference reference =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = reference.putFile(imageFile);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      await storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) async {
        print(downloadUrl);
        await _firestoreService.addImageUrl(
            authenticationService.currentUser.email, downloadUrl);
        Fluttertoast.showToast(
            msg: 'Update Sucessfull',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red);
        setBusy(false);
      }, onError: (err) {
        setBusy(false);
        Fluttertoast.showToast(msg: 'This file is not an image');
      });
    } else {
      setBusy(false);
      Fluttertoast.showToast(
          msg: 'Profile Image wasn\'t Change',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red);
    }
  }

  signout() async {
    setBusy(true);
    await authenticationService.signout();
    await _navigationService.navigateTo(LoginViewRoute);
    setBusy(false);
  }
}
