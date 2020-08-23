import 'package:chatIt/model/messages.dart';
import 'package:chatIt/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  final _firestore = Firestore.instance;
  final _chatCollectionRefrence = Firestore.instance.collection('chats');
  final _userCollectionRefrence = Firestore.instance.collection('user');
  final _friendCollectionRefrence = Firestore.instance.collection('user');
  final _friendRequestCollectionRefrence =
      Firestore.instance.collection('user');

  create(Users currentUser) async {
    await _userCollectionRefrence
        .document(currentUser.email)
        .setData(currentUser.toJson());
  }

  addImageUrl(String email, String imageUrl) async {
    await _userCollectionRefrence
        .document(email)
        .updateData({'imageUrl': imageUrl});
  }

  getUser(String email) async {
    try {
      var user = await _userCollectionRefrence.document(email).get();
      return Users.fromData(user.data);
    } catch (e) {
      print(e.toString());
    }
  }

//changes
  friendlist(String email) {
    try {
      return _friendCollectionRefrence
          .document(email)
          .collection('Friends')
          .snapshots()
          .map((event) =>
              event.documents.map((e) => Users.fromData(e.data)).toList());
    } catch (e) {
      print(e.toString());
    }
  }

  //New Chaanges,xxxxxxxxxxxxxxxxxxxxxxxxxxx
  unacceptedFriendRequest(String email) {
    //Todo UnacceptedFriendReqiuest
    return _friendCollectionRefrence
        .document(email)
        .collection('Pending Request')
        .snapshots()
        .map((event) =>
            event.documents.map((e) => Users.fromData(e.data)).toList());
  }

//Todo tjtjeo
  addToUnacceptedRequest(String email, Users peerUser) async {
    await _friendCollectionRefrence
        .document(email)
        .collection('Pending Request')
        .document(peerUser.email)
        .setData(peerUser.toJson());
  }

  creatfriendRequest(Users user, String email) async {
    await _friendRequestCollectionRefrence
        .document(email)
        .collection('request')
        .document(user.email)
        .setData(user.toJson());
  }

  searchUser(String email) async {
    bool ok;
    await _firestore.collection('user').document(email).get().then((onexist) {
      onexist.exists ? ok = true : ok = false;
    });
    return ok == true ? true : false;
  }

//changes
  friendrequestSnapshots(String email) {
    return _friendCollectionRefrence
        .document(email)
        .collection('request')
        .snapshots()
        .map((event) =>
            event.documents.map((e) => Users.fromData(e.data)).toList());
  }

  addToFriendList(
      String email, String peerEmail, Users friend, Users personal) async {
    await _friendCollectionRefrence
        .document(email)
        .collection('Friends')
        .document(peerEmail)
        .setData(friend.toJson());
    await _friendCollectionRefrence
        .document(peerEmail)
        .collection('Friends')
        .document(email)
        .setData(personal.toJson());
  }

//changes
  deleteFromFriendRequest(String email, String peerEmail) async {
    return await _friendCollectionRefrence
        .document(email)
        .collection('request')
        .document(peerEmail)
        .delete();
  }

  chatSnapshots(String groupId) {
    return _chatCollectionRefrence
        .document(groupId)
        .collection(groupId)
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((event) =>
            event.documents.map((e) => Message.fromJson(e.data)).toList());
  }

  chatMesaages(String groupId, Message message) async {
    await _chatCollectionRefrence
        .document(groupId)
        .collection(groupId)
        .document(DateTime.now().millisecondsSinceEpoch.toString())
        .setData(message.toJson());
  }
}
