import 'package:flutter/material.dart';

Widget largeContainer(String text, {Color color, Color textColor}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10,
    ),
    decoration: BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        width: color == null ? 0.4 : 0,
        color: Colors.black.withOpacity(0.8)
      )
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor ?? Colors.black.withOpacity(0.8),
        fontFamily: 'Varela',
        fontSize: 14,
      ),
    ),
  );
}