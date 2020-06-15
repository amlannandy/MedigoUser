import 'package:flutter/material.dart';

Widget doctorFieldButton(BuildContext context, { String text, Function onPress }) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: RaisedButton(
        color: Theme.of(context).primaryColor.withOpacity(0.8),
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}