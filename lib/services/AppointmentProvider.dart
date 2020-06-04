import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Appointment.dart';
import '../screens/ChatScreen.dart';

class AppointmentProvider {

  static Firestore _firestore = Firestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;
  

  static createAppointment(BuildContext context, String doctorId) async {
    FirebaseUser user = await _auth.currentUser();
    String appointmentId = Firestore.instance.collection('appointment').document().documentID;
    Firestore.instance.collection('appointments').document(appointmentId).setData({
      'userId' : user.uid,
      'doctorId' : doctorId,
      'timing' : Timestamp.now(),
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

}