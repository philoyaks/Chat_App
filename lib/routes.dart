import 'package:chatIt/screen/chatScreen.dart';
import 'package:chatIt/screen/homeScreen.dart';
import 'package:chatIt/screen/loginScreen.dart';
import 'package:chatIt/screen/signupScreen.dart';
import 'package:chatIt/screen/startUp.dart';

import 'package:flutter/material.dart';

import 'constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginPage(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: RegisterPage(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeScreen(),
      );
    case ChatViewRoute:
      var gropName = settings.arguments as List;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChatPageScreen(
          groupChatId: gropName,
        ),
      );
    case StartUpVieRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StartUp(),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
