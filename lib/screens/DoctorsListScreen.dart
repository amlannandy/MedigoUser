import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Doctor.dart';
import '../widgets/CustomText.dart';
import '../widgets/DoctorCard.dart';

class DoctorsListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.025,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Text(
              'Our Doctors',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.78,
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('doctors').snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingBanner();
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
          ),
        ],
      ),
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