import 'package:chatIt/screen/profile.dart';
import 'package:chatIt/viewModel/homeScreen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'friendRequest.dart';

class PopUpMenu extends ViewModelWidget<HomeViewModel> {
  const PopUpMenu({
    Key key,
    @required String selection,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return PopupMenuButton<String>(
      onSelected: (String value) async {
        if (value == 'request') {
          _scaffoldKey.currentState.showBottomSheet((context) {
            return FriendRequest();
          });
        } else if (value == 'logout') {
          await model.signout();
        } else if (value == 'profile') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditProfilePage()));
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'profile',
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ),
        // const PopupMenuItem<String>(
        //   value: 'nightmode',
        //   child: ListTile(
        //     leading: Icon(Icons.brightness_medium),
        //     title: Text('Pending Request'),
        //   ),
        // ),
        const PopupMenuItem<String>(
          value: 'request',
          child: ListTile(
            leading: Icon(Icons.queue),
            title: Text('Request'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
          ),
        ),
      ],
    );
  }
}
