import 'package:flutter/material.dart';

import '../../../models/Appointment.dart';
import '../../../services/AppointmentProvider.dart';

Widget timeSlotCard(BuildContext context, Appointment appointment) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(
      top: 10,
      left: 10,
      right: 10,
    ),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey[350],
          blurRadius: 20.0,
          spreadRadius: 0.02,
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Colors.black.withOpacity(0.2),
        width: 0.4,
      )
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                appointment.date,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20,
                ),
              ),
              Text(
                appointment.time,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        customButton(context, appointment),
      ],
    ),
  );
}

Widget  customButton(BuildContext context, Appointment appointment) {
  return Container(
    width: 100,
    margin: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10,
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: FlatButton(
      onPressed: () => AppointmentProvider.bookAppointmentConfirmation(context, appointment.id, appointment.doctorId), 
      child: Text(
        'Book',
        style: TextStyle(
          fontFamily: 'Varela',
          color: Colors.white,
          fontSize: 18,
        ),
      )
    )
  );
}