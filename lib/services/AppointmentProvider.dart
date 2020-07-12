import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Query.dart' as Query;
import '../screens/LoadingScreen.dart';
import '../models/Appointment.dart';
import '../screens/ChatScreen/screens/ChatScreen.dart';
import '../screens/ChatScreen/screens/VideoCallScreen.dart';

class AppointmentProvider {

  static Firestore _firestore = Firestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static createAppointment(BuildContext context, String appointmentId, String doctorId, String reportId) async {
    FirebaseUser user = await _auth.currentUser();
    if (reportId != null) {
      _firestore.collection('reports').document(reportId).updateData({
        'appointmentId' : appointmentId,
      });
    }
    Firestore.instance.collection('appointments').document(appointmentId).updateData({
      'userId' : user.uid,
      'isBooked' : true,
      'reportId' : reportId,
    });
    _firestore.collection('medicalreports').document(appointmentId).updateData({
      'userId' : user.uid,
    });
    _firestore.collection('prescriptions').document(appointmentId).updateData({
      'userId': user.uid
    });
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => ChatScreen(Appointment(
        userId: user.uid,
        doctorId: doctorId,
        id: appointmentId,
      )),
    ));
  }

  static void updateLastSeen(String appointmentId) {
    Firestore.instance.collection('appointments').document(appointmentId).updateData({
      'userLastSeen' : Timestamp.now(),
    });
  }

  static void sendMessage(String appointmentId, String userId, String doctorId, String message) {
    if (message.isEmpty) {
      return;
    }
    _firestore.collection('appointments').document(appointmentId).collection('messages').document(Timestamp.now().toString()).setData({
      'senderId' : userId,
      'receiverId' : doctorId,
      'message' : message,
      'timestamp' : Timestamp.now(),
    });
    _firestore.collection('appointments').document(appointmentId).updateData({
      'lastMessage' : message,
      'lastTimestamp' : Timestamp.now(),
      'userLastSeen' : Timestamp.now(),
    });
  }

  static String getFormattedDate(Timestamp timestamp) {
    return DateFormat('dd-MM-yyyy').format(timestamp.toDate()).toString();
  }

  static String getFormattedTime(Timestamp timestamp) {
    return DateFormat('kk:mm').format(timestamp.toDate());
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

  static void bookAppointmentConfirmation(BuildContext context, String appointmentId, String doctorId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.black, fontFamily: 'Lato'),
        ),
        content: Text(
          'Are you sure you want to book this Appointment?',
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
              createAppointment(context, appointmentId, doctorId, null);
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

  static void uploadMedicalReport({BuildContext context, String userId, List<Query.Query> queries}) {
    String reportId = _firestore.collection('reports').document().documentID;
    _firestore.collection('reports').document(reportId).setData({
      'userId' : userId,
      'timestamp' : Timestamp.now(),
    });
    queries.forEach((query) {
      _firestore.collection('reports').document(reportId).collection('queries').document().setData({
        'query' : query.query,
        'byBot' : query.byBot,
        'onlyText' : query.onlyText,
      });
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => LoadiingScreen(reportId: reportId)));
  }

  static void updateMedicalReport(String appointmentId, String text) {
    _firestore.collection('medicalreports').document(appointmentId).updateData({
      'data': text
    });
  }

  static void submitFeedback({ BuildContext context, String appointmentId, double rating, bool problemSolved, bool isAttentive, bool fastResponse, String other }) {
    _firestore.collection('appointments').document(appointmentId).updateData({
      'feedback' : {
        'rating': rating,
        'text': other,
        'others': {
          'isAttentive': isAttentive,
          'problemSolved': problemSolved,
          'fastResponse': fastResponse,
        }
      }
    });
    Fluttertoast.showToast(msg: "Thank you for Feedback", backgroundColor: Colors.green, textColor: Colors.white);
    Navigator.of(context).pop();
  }

}