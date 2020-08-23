import 'package:chatIt/constants.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: CircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(kbackground2),
          ))),
    );
  }
}
