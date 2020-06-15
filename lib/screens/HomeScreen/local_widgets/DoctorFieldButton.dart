import 'package:flutter/material.dart';

Widget doctorFieldButton(BuildContext context, { String text, Function onPress }) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ),
    child: FlatButton(
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Varela',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white
        ),
      ),
    ),
  );
}