import 'package:chatIt/locator.dart';
import 'package:chatIt/routes.dart';
import 'package:chatIt/screen/loginScreen.dart';
import 'package:chatIt/services/navigatorServices.dart';
import 'package:flutter/material.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat_It',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff5d1049),
        buttonColor: Color(0xff720D5D),
        textSelectionColor: Colors.purple[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: generateRoute,
      home: LoginPage(),
      // Chat(
      //   peerAvatar: 'fjjfjf',
      //   peerId: 'djdjd',
      // ),
    );
  }
}
