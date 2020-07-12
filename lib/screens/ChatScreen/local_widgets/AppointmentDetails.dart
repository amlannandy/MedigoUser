import 'package:flutter/material.dart';

import '../../../models/Appointment.dart';

Widget appointmentDetails(BuildContext context, Appointment appointment) {
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
          appointment.date,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Lato',
            color: Colors.white.withOpacity(0.8)
          ),
        ),
        SizedBox(height: 10),
        Text(
          appointment.time,
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'Lato',
            color: Colors.white.withOpacity(0.8)
          ),
        ),
      ],
    ),
  );
}