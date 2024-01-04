import 'package:flutter/material.dart';

Widget buildErrorScreen() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFe3e3e3),
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: Text(
          "Error retrieving movie",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
