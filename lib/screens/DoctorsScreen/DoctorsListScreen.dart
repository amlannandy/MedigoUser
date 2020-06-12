import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/Doctor.dart';
import './local_widgets/DoctorCard.dart';
import './local_widgets/EmptyBanner.dart';
import '../../widgets/LoadingSpinner.dart';

class DoctorsListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('doctors').where('isVerified', isEqualTo: true).snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingSpinner(context);
          }
          if (!snapshot.hasData) {
            return emptyBanner(context);
          }
          final doctorsDocuments = snapshot.data.documents;
          print(doctorsDocuments);
          List<Doctor> doctors = [];
          doctorsDocuments.forEach((doctor) {
            doctors.add(Doctor.fromFirestore(doctor));
          });
          if (doctors.isEmpty) {
            return emptyBanner(context);
          }
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (ctx, index) => doctorCard(context, doctors[index]),
            itemCount: doctors.length,
          );
        },
      ),
    );
  }
}