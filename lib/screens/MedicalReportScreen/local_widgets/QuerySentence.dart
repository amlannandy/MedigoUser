import 'package:Medigo/models/Query.dart';
import 'package:flutter/material.dart';

Widget querySentence(Query query) {
  return Container(
    child: Text(
      query.byBot ? query.query : "${query.query}\n",
      style: TextStyle(
        color: query.byBot ? Colors.black.withOpacity(0.8) : Colors.grey,
        fontSize: query.byBot ? 14 : 12,
        fontFamily: 'Varela',
      ),
    ),
  );
}