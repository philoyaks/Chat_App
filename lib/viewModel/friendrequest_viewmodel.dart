import 'package:chatIt/model/user.dart';
import 'package:chatIt/services/authenticationServices.dart';
import 'package:chatIt/services/firestoreServices.dart';
import 'package:chatIt/viewModel/homeScreen_viewmodel.dart';

import '../locator.dart';

class FriendRequestViewModel extends HomeViewModel {
  final authenticationService = locator<AuthenticationService>();
  final _firestoreService = locator<FireStoreServices>();

  checkLogin() async {
    await authenticationService.isUserLoggedIn();
  }

  friendSnapshot() {
    return _firestoreService
        .friendrequestSnapshots(authenticationService.currentUser.email);
  }

  acceptFriendRequest(String peerEmail, Users peerUser) async {
    try {
      await _firestoreService.addToFriendList(
          authenticationService.currentUser.email,
          peerEmail,
          peerUser,
          authenticationService.currentUser);
      await _firestoreService.deleteFromFriendRequest(
          authenticationService.currentUser.email, peerEmail);
    } catch (e) {
      print(e.toString());
    }
  }

  declineFriendRequest(String peerEmail) async {
    return await _firestoreService.deleteFromFriendRequest(
        authenticationService.currentUser.email, peerEmail);
  }
}
