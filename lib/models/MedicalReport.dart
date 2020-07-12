import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalReport {

  final String id;
  final String data;
  final String userId;
  final String doctorId;
  final String date;
  final String doctorName;

  MedicalReport({
    @required this.id,
    @required this.data,
    @required this.userId,
    @required this.doctorId,
    @required this.date,
    @required this.doctorName,
  });

  factory MedicalReport.fromFirestore(DocumentSnapshot snapshot) {
    final doc = snapshot.data;
    MedicalReport report = MedicalReport(
      id: snapshot.documentID,
      data: doc['data'] ?? '',
      userId: doc['userId'] ?? null,
      doctorId: doc['doctorId'] ?? null,
      date: doc['date'] ?? null,
      doctorName: doc['doctorName'] ?? 'Amlan Nandy'
    );
    return report;
  }

}