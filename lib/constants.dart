import 'package:flutter/material.dart';

const String LoginViewRoute = ' LoginPage';

const String ChatViewRoute = ' ChatPage';

const String HomeViewRoute = 'HomeScreenPage';

const String SignUpViewRoute = 'SignUpPage';

const String StartUpVieRoute = "StartUpViewRoute";

var kpadding = 20.0;
var kbackground = Colors.white;
var kbackground2 = Color(0xff5d1049);
var kinpColor = Color(0xff720D5D);
var kinpColor2 = Color(0x80720D5D);
var kinpColor3 = Color(0xff5d1049);

var kTextyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2);

var kTexstyleChat =
    TextStyle(color: Colors.black, fontSize: 15, letterSpacing: 1.2);

var kTextChat = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2);

var kinputDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: kinpColor2,
          width: 2,
        )),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        )),
    contentPadding: EdgeInsets.symmetric(horizontal: kpadding),
    focusColor: kinpColor,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white, width: 1)));
