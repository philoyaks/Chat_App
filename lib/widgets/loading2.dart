import "package:flutter/material.dart";

import '../constants.dart';

Widget loading2() {
  return CircularProgressIndicator(
    strokeWidth: 3,
    backgroundColor: Colors.white,
    valueColor: AlwaysStoppedAnimation(kbackground2),
  );
}
