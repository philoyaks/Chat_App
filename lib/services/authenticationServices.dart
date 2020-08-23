import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatIt/model/user.dart';

import '../locator.dart';
import 'firestoreServices.dart';

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestoreService = locator<FireStoreServices>();

  Users _currentUser;

  Users get currentUser => _currentUser;

  Future loginWithEmail(
    @required String email,
    @required String password,
  ) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await populateCurrentUser(user.user);
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signupWithEmail({
    @required String email,
    @required String password,
    @required String firstName,
    @required String lastName,
    @required String phoneNumber,
  }) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _currentUser = Users(
        id: authResult.user.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        phoneNumber: phoneNumber,
      );
      await _firestoreService.create(_currentUser);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _auth.currentUser();
    await populateCurrentUser(user);
    return user != null;
  }

  Future populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.email);
      notifyListeners();
    }
  }

  Future signout() async {
    var user = await _auth.signOut();
    return user;
  }
}
