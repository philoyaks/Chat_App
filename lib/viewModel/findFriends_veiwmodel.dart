import 'package:chatIt/model/user.dart';
import 'package:chatIt/services/authenticationServices.dart';
import 'package:chatIt/services/firestoreServices.dart';
import 'package:chatIt/services/navigatorServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import '../locator.dart';

class SearchViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final navigationService = locator<NavigationService>();

  final _firestoreService = locator<FireStoreServices>();
  Users _user;
  Users get user => _user;

  searchFriends(String email) async {
    if (email == "") {
      Fluttertoast.showToast(
          msg: "input Email", toastLength: Toast.LENGTH_LONG);
      return;
    }
    setBusy(true);
    var result = await _firestoreService.searchUser(email);
    if (result) {
      _user = await _firestoreService.getUser(email);
      notifyListeners();
    }
    setBusy(false);
    return result;
  }

  sendRequest(Users user) async {
    await _authenticationService.isUserLoggedIn();
    if (user.email == _authenticationService.currentUser.email) {
      Fluttertoast.showToast(
          msg: 'You cant Send Friendrequest to self',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red);
      return;
    }
    await _firestoreService.creatfriendRequest(
        _authenticationService.currentUser, user.email);
  }
}
