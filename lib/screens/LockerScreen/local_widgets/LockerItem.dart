import 'package:flutter/material.dart';

import '../../../models/MedicalReport.dart';
import '../../../screens/ChatScreen/screens/ReportScreen.dart';
import '../../../screens/DoctorsScreen/local_widgets/SmallIconButton.dart';

Widget lockerItem(BuildContext context, String collectionName, MedicalReport report) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(
      top: 10,
      left: 10,
      right: 10,
    ),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey[350],
          blurRadius: 20.0,
          spreadRadius: 0.02,
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              report.date,
              style: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
                fontSize: 22,
              ),
            ),
            Text(
              'Dr ' + report.doctorName,
              style: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(0.6),
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
                fontSize: 18,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            smallIconButton(
              context,
              icon: Icons.visibility,
              text: 'View Doc ',
              color: Theme.of(context).accentColor,
              onPress: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => ReportScreen(
                  report.id, 
                  collectionName == 'prescriptions' ? true : false,
                  )
                )
              ),
            ),
            SizedBox(height: 10),
            smallIconButton(
              context,
              icon: Icons.cloud_download,
              text: 'Download',
              color: Theme.of(context).accentColor,
              onPress: () {},
            ),
          ],
        )
      ],
    ),
  );
}