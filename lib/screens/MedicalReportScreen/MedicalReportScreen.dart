
import 'package:Medigo/widgets/LoadingSpinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './local_widgets/CustomAppBar.dart';
import './local_widgets/QuerySentence.dart';
import '../../models/Query.dart' as Query;

class MedicalReportScreen extends StatelessWidget {

  final _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {

    final reportId = 'IWSDhop0KYdqVhdUIbll';//ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: customAppBar(context, 'Medical Report'),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('reports').document(reportId).collection('queries').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingSpinner(context);
          }
          if (!snapshot.hasData) {
            return Container();
          }
          final List<Query.Query> queries = [];
          final docs = snapshot.data.documents;
          docs.forEach((doc) => queries.add(Query.Query.fromFirestore(doc)) );
          return ListView.builder(
            itemBuilder: (ctx, index) => querySentence(queries[index]),
            itemCount: queries.length,
          );
        }
      ),
    );
  }
}