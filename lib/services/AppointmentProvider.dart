import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Appointment.dart';
import '../screens/ChatScreen.dart';
import '../screens/VideoCallScreen.dart';

class AppointmentProvider {

  static Firestore _firestore = Firestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;
  

  static createAppointment(BuildContext context, String doctorId) async {
    FirebaseUser user = await _auth.currentUser();
    String appointmentId = Firestore.instance.collection('appointment').document().documentID;
    Firestore.instance.collection('appointments').document(appointmentId).setData({
      'userId' : user.uid,
      'doctorId' : doctorId,
      'time' : Timestamp.now(),
    });
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => ChatScreen(Appointment(
        userId: user.uid,
        doctorId: doctorId,
        id: appointmentId,
      )),
    ));
  }

  static void sendMessage(String appointmentId, String userId, String message) {
    if (message.isEmpty) {
      return;
    }
    _firestore.collection('appointments').document(appointmentId).collection('messages').document(Timestamp.now().toString()).setData({
      'senderId' : userId,
      'message' : message,
      'timestamp' : Timestamp.now(),
    });
  }

  static void joinVideoCall(BuildContext context, String appointmentId, String channnelId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
        ),
        content: Text(
          'Are you sure you want to join this call?',
          style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'No',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FlatButton(
            onPressed: () { 
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => VideoCallScreen(
                    channelName: channnelId,
                    appointmentId: appointmentId,
                    audioOnly: false,
                  )
                )
              );
            },
            child: Text(
              'Yes',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )
    );
  }

  static void joinAudioCall(BuildContext context, String appointmentId, String channnelId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
        ),
        content: Text(
          'Are you sure you want to join this call?',
          style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'No',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FlatButton(
            onPressed: () { 
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => VideoCallScreen(
                    channelName: channnelId,
                    appointmentId: appointmentId,
                    audioOnly: true,
                  )
                )
              );
            },
            child: Text('Yes',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )
    );
  }

}