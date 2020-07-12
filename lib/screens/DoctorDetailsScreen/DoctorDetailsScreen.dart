import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../models/Doctor.dart';
import '../../models/DoctorArgs.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/PrimaryButton.dart';

class DoctorDetailsScreen extends StatelessWidget {

  final Doctor doctor;

  DoctorDetailsScreen(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Know more'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            profileRow(context, doctor),
            ratingContainer(context, 4.5),
            PrimaryButton(
              text: 'Book Appointment', 
              press: () => Navigator.of(context).pushReplacementNamed('/timeslot', arguments: DoctorArgs(
                id: doctor.userId,
                name: doctor.name,
                field: doctor.field,
                imageUrl: doctor.imageUrl,
                )
              ),
              color: Theme.of(context).primaryColor
            ),
            dataPacket(context, 'Experience', "${doctor.experience} years"),
            dataPacket(context, 'Hospital', doctor.hospital),
            dataPacket(context, 'City', doctor.city),
          ],
        ),
      ),
    );
  }

  Widget profileRow(BuildContext context, Doctor doctor) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(doctor.imageUrl),
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          Column(
            children: <Widget>[
              Text(
                'Dr. ' + doctor.name,
                style: TextStyle(
                  fontFamily: 'Varela',
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 18
                ),
              ),
              Text(
                doctor.field,
                style: TextStyle(
                  fontFamily: 'Varela',
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget ratingContainer(BuildContext context, double rating) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          width: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                LineIcons.star,
                color: Colors.black.withOpacity(0.8),
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                rating.toStringAsFixed(1)
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget dataPacket(BuildContext context, String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(2.5, 10, 2.5, 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
            ),
            child: Text(
              key,
              style: TextStyle(
                fontFamily: 'Varela',
                color: Colors.white.withOpacity(0.6),
                fontSize: 14
              ),
            ),
          ),
          Container(
            width: 200,
            padding: const EdgeInsets.fromLTRB(10, 10, 2.5, 10),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
            ),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Varela',
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                fontSize: 14
              ),
            ),
          ),
        ],
      ),
    );
  }
}