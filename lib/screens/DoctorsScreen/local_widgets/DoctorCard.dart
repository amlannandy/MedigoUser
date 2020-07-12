import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../models/Doctor.dart';
import '../local_widgets/DataPacket.dart';
import '../local_widgets/RatingContainer.dart';
import '../local_widgets/SmallIconButton.dart';
import '../../../models/DoctorArgs.dart';
import '../../../screens/DoctorDetailsScreen/DoctorDetailsScreen.dart';

Widget doctorCard(BuildContext context, Doctor doctor) {
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
    child: Column(
      children: <Widget>[
        profileRow(context, doctor),
        SizedBox(height: 10,),
        buttonsRow(context, doctor),
      ],
    ),
  );
}

Widget profileRow(BuildContext context, Doctor doctor) {
  return Container(
    child: Row(
      children: <Widget>[
        CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(doctor.imageUrl),
            backgroundColor: Colors.white,
          ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Dr. ' + doctor.name,
              style: TextStyle(
                fontFamily: 'Varela',
                color: Colors.black.withOpacity(0.8),
                fontSize: 18
              ),
            ),
            SizedBox(height: 8),
            dataPacket(doctor.field),
            SizedBox(height: 8),
            dataPacket(
              doctor.experience.toStringAsFixed(0) + ' Years Experience',
              color: Theme.of(context).primaryColor,
              textColor: Colors.white.withOpacity(0.8)
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buttonsRow(BuildContext context, Doctor doctor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      ratingContainer(context, 3.5),
      smallIconButton(
        context,
        icon: LineIcons.users,
        text: 'Consult',
        onPress: () => Navigator.of(context).pushNamed('/timeslot', arguments: DoctorArgs(
          id: doctor.userId,
          name: doctor.name,
          field: doctor.field,
          imageUrl: doctor.imageUrl,
          )
        ),
      ),
      smallIconButton(
        context,
        icon: LineIcons.chevron_right,
        text: 'Know more',
        onPress: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DoctorDetailsScreen(doctor))),
      ),
    ],
  );
}
