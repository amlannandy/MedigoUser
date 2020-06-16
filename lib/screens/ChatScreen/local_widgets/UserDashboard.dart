import 'package:Medigo/screens/ChatScreen/local_widgets/AppointmentDetails.dart';
import 'package:Medigo/screens/ChatScreen/local_widgets/ListTile.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class UserDashboard extends StatelessWidget {

  final listItems = [
    [LineIcons.sticky_note, 'Medical Report', 'View your Report', () => {}],
    [LineIcons.file_text, 'Prescription', "View Doctor's Prescription", () => {}],
    [LineIcons.phone, 'Audio Call', 'Contact Doctor via Audio', () => {}],
    [LineIcons.video_camera, 'Video Call', 'Contact Doctor via Video', () => {}],
    [LineIcons.hospital_o, 'Go Offline', 'Book Offline Consulation', () => {}],
    [LineIcons.user, 'Submit Feedback', 'Share your Experience', () => {}],
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          appointmentDetails(context),
          for (var item in listItems) listTile(
            icon: item[0],
            title: item[1],
            subtitle: item[2],
            onPress: item[3]
          )
        ],
      ),
    );
  }
}