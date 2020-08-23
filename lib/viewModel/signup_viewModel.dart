import 'dart:io';
import 'package:chatIt/locator.dart';
import 'package:chatIt/model/api.dart';
import 'package:chatIt/services/authenticationServices.dart';
import 'package:chatIt/services/firestoreServices.dart';
import 'package:chatIt/services/navigatorServices.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

import '../constants.dart';

class SignUpViewModel extends BaseViewModel {
  final _authenticationServices = locator<AuthenticationService>();
  final navigationService = locator<NavigationService>();

  final _firestoreService = locator<FireStoreServices>();
  var _imageUrl;
  String get imageUrl => _imageUrl;

  signUp(
      {@required String email,
      @required String password,
      @required String firstName,
      @required String lastName,
      @required String phoneNumber,
      @required File imageFile}) async {
    if (email == "") {
      Fluttertoast.showToast(
          msg: "Email field can't be empty", backgroundColor: Colors.red);
      return;
    } else if (password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Password field can't be empty", backgroundColor: Colors.red);
      return;
    } else if (lastName.isEmpty) {
      Fluttertoast.showToast(
          msg: "Fullname field can't be empty", backgroundColor: Colors.red);
      return;
    } else if (firstName.isEmpty) {
      Fluttertoast.showToast(
          msg: "username field can't be empty", backgroundColor: Colors.red);
      return;
    } else if (phoneNumber.isEmpty) {
      Fluttertoast.showToast(
          msg: "username field can't be empty", backgroundColor: Colors.red);
      return;
    }
    setBusy(true);

    var result = await _authenticationServices.signupWithEmail(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
    if (result is bool) {
      if (result) {
        await uploadFile(imageFile, email);
        await navigationService.navigateTo(HomeViewRoute);
        setBusy(false);
      } else {
        setBusy(false);
        print('Not Availaible');
        Fluttertoast.showToast(msg: 'Sign up failed');
      }
    } else {
      setBusy(false);
      print(result);
      Fluttertoast.showToast(msg: result, backgroundColor: Colors.red);
    }
  }

  Future uploadFile(File imageFile, String email) async {
    if (imageFile != null) {
      String fileName =
          '$email/${DateTime.now().millisecondsSinceEpoch.toString()}';
      StorageReference reference =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = reference.putFile(imageFile);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      await storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) async {
        print(downloadUrl);
        await _firestoreService.addImageUrl(email, downloadUrl);
      }, onError: (err) {
        Fluttertoast.showToast(msg: 'This file is not an image');
      });
    } else {
      await _firestoreService.addImageUrl(email, kimageUrl);
    }
  }
}
