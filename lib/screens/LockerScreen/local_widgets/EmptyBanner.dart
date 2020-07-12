import 'package:flutter/material.dart';

Widget emptyBanner(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/locker.png',
          height: 200,
        ),
        SizedBox(height: 20,),
        Text(
          'Locker is Empty',
          style: TextStyle(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Varela',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}