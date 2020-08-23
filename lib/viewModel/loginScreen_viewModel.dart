import 'package:chatIt/services/authenticationServices.dart';
import 'package:chatIt/services/navigatorServices.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import '../constants.dart';
import '../locator.dart';

class LoginViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final navigationService = locator<NavigationService>();
  Future login({@required String email, @required String password}) async {
    if (email == "") {
      Fluttertoast.showToast(
          msg: "Email field can't be empty", backgroundColor: Colors.red);
      return;
    } else if (password == "") {
      Fluttertoast.showToast(
          msg: "Password field can't be empty", backgroundColor: Colors.red);
      return;
    } else if (password.length < 6) {
      Fluttertoast.showToast(
          msg: "Password Must be at least 6 characters",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
    } else {
      setBusy(true);

      var result = await _authenticationService.loginWithEmail(email, password);

      if (result is bool) {
        if (result) {
          await navigationService.navigateTo(HomeViewRoute);
          setBusy(false);
        } else {
          setBusy(false);
          Fluttertoast.showToast(msg: "Login Failed, Please try again later");
        }
      } else {
        setBusy(false);
        Fluttertoast.showToast(
            msg: result,
            backgroundColor: kbackground2,
            timeInSecForIosWeb: 3,
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  navigate() async {
    await navigationService.navigateTo(SignUpViewRoute);
  }

  // Future signInWithGoogle() async {
  //   await authenticationService.signinwithGoogle();
  // }
}
