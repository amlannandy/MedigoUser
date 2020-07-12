import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Query {

  final String query;
  final bool byBot;
  final bool onlyText;

  Query({

    @required this.query,
    @required this.byBot,
    this.onlyText = true,
  });

  factory Query.fromFirestore(DocumentSnapshot snapshot) {
    final doc = snapshot.data;
    Query query = Query(
      query: doc['query'] ?? null,
      byBot: doc['byBot'] ?? false,
      onlyText: doc['onlyText'] ?? true,
    );
    return query;
  }

}