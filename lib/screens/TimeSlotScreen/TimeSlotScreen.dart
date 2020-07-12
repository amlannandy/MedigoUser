import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/DoctorArgs.dart';
import '../../models/Appointment.dart';
import './local_widgets/EmptyBanner.dart';
import '../../widgets/LoadingSpinner.dart';
import './local_widgets/TimeSlotAppBar.dart';
import '../../services/AppointmentProvider.dart';
import './local_widgets/TimeSlotCard.dart';

class TimeSlotScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final DoctorArgs doctorArgs = ModalRoute.of(context).settings.arguments;
    final doctorId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: timeSlotAppBar(context, doctorArgs),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('appointments')
          .where('doctorId', isEqualTo: doctorArgs == null ? doctorId : doctorArgs.id)
          .where('date', isEqualTo: AppointmentProvider.getFormattedDate(Timestamp.now()))
          .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingSpinner(context);
          }
          List<Appointment> appointments = [];
          final docs = snapshot.data.documents;
          docs.forEach((doc) {
            if(doc['userId'] == null) {
              appointments.add(Appointment.fromFirestore(doc));
            }
          });
          if (appointments.isEmpty) {
            return emptyBanner(context);
          }
          return ListView.builder(
            itemBuilder: (ctx, index) => timeSlotCard(context, appointments[index]),
            itemCount: appointments.length,
          );
        }
      ),
    );
  }
}