import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'LockerItem.dart';
import 'EmptyBanner.dart';
import '../../../models/MedicalReport.dart';
import '../../../widgets/LoadingSpinner.dart';

class CustomList extends StatelessWidget {

  final String collectionName;
  final String userId;

  CustomList({ this.collectionName, this.userId });

  final _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db.collection(collectionName).where('userId', isEqualTo: userId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
          return loadingSpinner(context);
        }
        List<MedicalReport> reports = [];
        final docs = snapshot.data.documents;
        docs.forEach((doc) => reports.add(MedicalReport.fromFirestore(doc)));
        if (reports.isEmpty) {
          return emptyBanner(context);
        }
        return ListView.builder(
          itemBuilder: (ctx, index) => lockerItem(context, collectionName, reports[index]),
          itemCount: reports.length,
        );
      }
    );
  }
}