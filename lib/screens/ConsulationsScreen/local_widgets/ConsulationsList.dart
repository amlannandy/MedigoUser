import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/Appointment.dart';
import '../local_widgets/EmptyBanner.dart';
import '../local_widgets/ConsulationCard.dart';

Widget consulationsList(BuildContext context, String userId) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('appointments').where('userId', isEqualTo: userId).snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        if (!snapshot.hasData) {
          return Container();
        }
        final appointmentDocuments = snapshot.data.documents;
        print(appointmentDocuments);
        List<Appointment> appointments = [];
        appointmentDocuments.forEach((doctor) {
          appointments.add(Appointment.fromFirestore(doctor));
        });
        if (appointments.isEmpty) {
          return emptyBanner(context);
        }
        appointments.sort((a, b) => a.lastTimestamp.toDate().compareTo(b.lastTimestamp.toDate()));
        appointments.reversed;
        appointments = new List.from(appointments.reversed);
        return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (ctx, index) => ConsultationCard(appointments[index]),
          itemCount: appointments.length,
        );
      },
    ),
  );
}