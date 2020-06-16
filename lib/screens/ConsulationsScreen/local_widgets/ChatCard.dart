import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../../models/Doctor.dart';
import '../../../models/Appointment.dart';
import '../../../services/UserDatabaseService.dart';
import '../../ChatScreen/screens/ChatScreen.dart';

final UserDatabaseService userDatabaseService = UserDatabaseService();

Widget chatCard(BuildContext context, Appointment appointment) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => ChatScreen(appointment),
    )),
    child: Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: appointment.lastTimestamp.toDate().compareTo(appointment.userLastSeen.toDate()) > 0 ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StreamBuilder<Doctor>(
            stream: userDatabaseService.streamDoctor(appointment.doctorId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                return Container();
              }
              final doctor = snapshot.data;
              return Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage: NetworkImage(doctor.imageUrl),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        doctor.name,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Varela',
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          appointment.lastMessage,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Varela',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          ),
          Column(
            children: <Widget>[
              Text(
                DateFormat('kk:mm').format(appointment.lastTimestamp.toDate()),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              SizedBox(height: 5.0),
                appointment.lastTimestamp.toDate().compareTo(appointment.userLastSeen.toDate()) > 0 ? Container(
                width: 40.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
              ) : Text(''),
            ],
          ),
        ],
      ),
    ),
  );
}