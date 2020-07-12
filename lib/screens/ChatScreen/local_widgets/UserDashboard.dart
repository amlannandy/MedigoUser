import 'package:Medigo/screens/ChatScreen/screens/ReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';

import '../local_widgets/ListTile.dart';
import 'package:Medigo/models/Appointment.dart';
import '../local_widgets/AppointmentDetails.dart';
import 'package:Medigo/services/AppointmentProvider.dart';

class UserDashboard extends StatelessWidget {

  final Appointment appointment;

  UserDashboard(this.appointment);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          appointmentDetails(context, appointment),
          listTile(
            icon: LineIcons.sticky_note,
            title: 'Medical Report',
            subtitle: 'Share your problems here',
            onPress: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ReportScreen(appointment.id, false))),
          ),
          listTile(
            icon: LineIcons.file_text,
            title: 'Prescription',
            subtitle: 'View Doctor\'s Prescription',
            onPress: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ReportScreen(appointment.id, true))),
          ),
          listTile(
            icon: LineIcons.phone,
            title: 'Audio Call',
            subtitle: 'Request a Audio call',
            onPress: () {
              AppointmentProvider.sendMessage(appointment.id, appointment.userId, appointment.doctorId, 'Patient wants to conect via Audio Call');
              Fluttertoast.showToast(msg: 'Request sent', backgroundColor: Colors.green, textColor: Colors.white);
              Navigator.of(context).pop();
            },
          ),
          listTile(
            icon: LineIcons.video_camera,
            title: 'Video Call',
            subtitle: 'Request a Video call',
            onPress: () {
              AppointmentProvider.sendMessage(appointment.id, appointment.userId, appointment.doctorId, 'Patient wants to conect via Video Call');
              Fluttertoast.showToast(msg: 'Request sent', backgroundColor: Colors.green, textColor: Colors.white);
              Navigator.of(context).pop();
            },
          ),
          listTile(
            icon: LineIcons.hospital_o,
            title: 'Go Offline',
            subtitle: 'Book Offline Consulation',
            onPress: () => Navigator.of(context).pushNamed('/timeslot'),
          ),
          listTile(
            icon: LineIcons.user,
            title: 'Submit Feedback',
            subtitle: 'Share your experience',
            onPress: () => Navigator.of(context).pushNamed('/feedback', arguments: appointment.id),
          ),
        ],
      ),
    );
  }
}