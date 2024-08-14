import 'package:flutter/material.dart';

Widget  defaultButton({
  double height=50.0,
  double width = 160.0,
  Color background = const Color(0xFF3D5CFF),
  bool isUpperCase = true,
  double radius = 15.0,
  double borderWidth = 0.5, // Add a parameter for border width

  Color borderColor = Colors.transparent, // Add a parameter for border color

  required void Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radius,
          ),
          color: background,
          border: Border.all(color: borderColor, width: borderWidth)),
    );
