import 'package:flutter/material.dart';

Widget buildLoadingScreen() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Color(0xFFE30B5C),
    child: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    ),
  );
}