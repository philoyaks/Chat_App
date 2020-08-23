import 'dart:io';

import 'package:chatIt/constants.dart';
import 'package:chatIt/viewModel/homeScreen_viewmodel.dart';
import 'package:chatIt/widgets/loading.dart';
import 'package:chatIt/widgets/showimageorcamera.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:stacked/stacked.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController bioEditingCOntroller = TextEditingController();
  File image;
  final picker = ImagePicker();
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (_) => _.checkCurrentUser(),
        builder: (context, model, child) => model.currentusers == null
            ? Loading()
            : SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    elevation: 0,
                    title: Text(
                      'Edit Profile',
                    ),
                  ),
                  body: Container(
                    height: height,
                    width: width,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            height: 130,
                            width: 140,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    backgroundColor: kinpColor,
                                    radius: 59,
                                    backgroundImage: image == null
                                        ? NetworkImage(
                                            model.currentusers.imageUrl)
                                        : FileImage(image),
                                  ),
                                ),
                                Positioned(
                                    top: 85,
                                    left: 90,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera,
                                      ),
                                      onPressed: () {
                                        showCameraSelection(context, getImage);
                                      },
                                      iconSize: 30,
                                      color: kbackground2,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        textInput2('First Name'),
                        nonContainerEdit(model.currentusers.firstName),
                        textInput2('Last Name'),
                        nonContainerEdit(model.currentusers.lastName),
                        textInput2('Email'),
                        nonContainerEdit(model.currentusers.email),
                        textInput2('Phone Number'),
                        nonContainerEdit(model.currentusers.phoneNumber),
                        SizedBox(
                          width: 30,
                          child: model.isBusy
                              ? Center(
                                  child: Container(
                                      height: 20, width: 20, child: Loading()))
                              : Center(
                                  child: RaisedButton(
                                    onPressed: () async {
                                      model.upDateProfile(image);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      'Update Profile Picture',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}

Widget nonContainerEdit(String text) {
  return Container(
    height: 40,
    margin: EdgeInsets.only(top: 5, bottom: 20),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: kinpColor2.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),
  );
}

Text textInput2(String text) {
  return Text(
    text,
  );
}
