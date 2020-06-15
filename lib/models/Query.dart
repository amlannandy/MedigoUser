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

}