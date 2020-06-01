import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/Doctor.dart';
import '../widgets/CustomText.dart';
import '../widgets/DoctorCard.dart';

class DoctorsListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('doctors').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingBanner();
        }
        if (!snapshot.hasData) {
          return emptyBanner(context);
        }
        final doctorsDocuments = snapshot.data.documents;
        List<Doctor> doctors = [];
        doctorsDocuments.forEach((doctor) {
          doctors.add(Doctor.fromFirestore(doctor));
        });
        if (doctors.isEmpty) {
          return emptyBanner(context);
        }
        return ListView.builder(
          itemBuilder: (ctx, index) => doctorCard(doctors[index]),
          itemCount: doctors.length,
        );
      },
    );
  }

  Widget loadingBanner() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
      ),
    );
  }

  Widget emptyBanner(BuildContext context) {
    return Center(
      child: CustomText(
        text: "No Doctors available",
        size: 16,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}