import 'package:flutter/material.dart';

import '../../../models/DoctorArgs.dart';

Widget timeSlotAppBar(BuildContext context, DoctorArgs args) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.black.withOpacity(0.7),
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
    backgroundColor: Colors.white,
    title: args == null ? Text(
      'Go Offline',
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontFamily: 'Lato',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ) : Row(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(args.imageUrl),
            ),
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              args.name,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              args.field,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ]
    ),
    bottom: PreferredSize(child: Container(color: Colors.black.withOpacity(0.8), height: 0.4,), preferredSize: Size.fromHeight(4.0)),
  );
}