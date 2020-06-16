import 'package:flutter/material.dart';

Widget appointmentDetails(BuildContext context) {
  return Container(
    height: 150,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 30),
        Text(
          '15 June 2020',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Lato',
            color: Colors.white.withOpacity(0.8)
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '16:00',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Lato',
                color: Colors.white.withOpacity(0.8)
              ),
            ),
            SizedBox(width: 10),
            Text(
              'to',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Colors.white.withOpacity(0.8)
              ),
            ),
            SizedBox(width: 10),
            Text(
              '17:30',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Lato',
                color: Colors.white.withOpacity(0.8)
              ),
            ),
          ],
        ),
      ],
    ),
  );
}