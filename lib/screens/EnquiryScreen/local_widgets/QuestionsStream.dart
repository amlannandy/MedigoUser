import 'package:flutter/material.dart';

import '../../../models/Query.dart';
import './QueryBubble.dart';

class QuestionsStream extends StatelessWidget {

  final List<Query> queries;

  QuestionsStream(this.queries);

  @override
  Widget build(BuildContext context) {

    final finalQueries = [...queries.reversed];

    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemBuilder: (ctx, index) => queryBubble(context, finalQueries[index]),
        itemCount: finalQueries.length,
      ),
    );
  }
}