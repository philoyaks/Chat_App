import 'dart:io';

import 'package:chatIt/viewModel/signup_viewModel.dart';
import 'package:chatIt/widgets/loading.dart';
import 'package:chatIt/widgets/loading2.dart';
import 'package:chatIt/widgets/showimageorcamera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'RegisterPage';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
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

  bool passwordConfirmer = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => model.isBusy
            ? Loading()
            : Scaffold(
                backgroundColor: kbackground,
                appBar: AppBar(
                  title: Text('Sign-Up'),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  radius: 59,
                                  backgroundImage: image == null
                                      ? AssetImage('assets/images/images.png')
                                      : FileImage(image)),
                            ),
                            Positioned(
                                top: 85,
                                left: 90,
                                child: IconButton(
                                  icon: Icon(Icons.camera),
                                  onPressed: () {
                                    showCameraSelection(context, getImage);
                                  },
                                  iconSize: 30,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: kpadding),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter first name' : null,
                                  onChanged: (value) {
                                    setState(() => firstName =
                                        value[0].toUpperCase() +
                                            value.substring(1));
                                  },
                                  decoration: kinputDecoration.copyWith(
                                    labelText: 'First name',
                                  )),
                              SizedBox(height: 20),
                              TextFormField(
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter Last name' : null,
                                  onChanged: (value) {
                                    setState(() => lastName =
                                        value[0].toUpperCase() +
                                            value.substring(1));
                                  },
                                  decoration: kinputDecoration.copyWith(
                                    labelText: 'Last name',
                                  )),
                              SizedBox(height: 20),
                              TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter E-mail' : null,
                                  onChanged: (value) {
                                    setState(() => email = value);
                                  },
                                  decoration: kinputDecoration.copyWith(
                                    labelText: 'email',
                                  )),
                              SizedBox(height: 20),
                              TextFormField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter Phone number' : null,
                                  onChanged: (value) {
                                    setState(() => phoneNumber = value);
                                  },
                                  decoration: kinputDecoration.copyWith(
                                    labelText: 'Phone no',
                                  )),
                              SizedBox(height: 20),
                              TextFormField(
                                  obscureText: true,
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter new password' : null,
                                  onChanged: (value) {
                                    setState(() => password = value);
                                  },
                                  decoration: kinputDecoration.copyWith(
                                    labelText: 'New_password',
                                  )),
                              SizedBox(height: 20),
                              TextFormField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    if (password != value) {
                                      setState(() => passwordConfirmer = true);
                                    } else {
                                      setState(() => passwordConfirmer = false);
                                    }
                                  },
                                  decoration: kinputDecoration.copyWith(
                                    labelText: 'Confirm password',
                                  )),
                              Center(
                                child: Text(
                                  passwordConfirmer
                                      ? 'The password do not match'
                                      : '',
                                  style: TextStyle(
                                      color: Colors.red[100],
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      try {
                                        model.signUp(
                                            email: email,
                                            password: password,
                                            firstName: firstName,
                                            lastName: lastName,
                                            phoneNumber: phoneNumber,
                                            imageFile: image);
                                      } catch (e) {
                                        print(e.toString());
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 5,
                                  color: kbackground2,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'already have an account?...Sign-In',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
