import 'package:flutter/material.dart';

import '../../../models/Query.dart';

Widget queryBubble(BuildContext context, Query query) {
  return Container(
    margin: EdgeInsets.only(
      top: 10,
      left: !query.byBot ? 0 : 10,
      right: !query.byBot ? 10 : 0,
    ),
    width: MediaQuery.of(context).size.width,
    alignment: !query.byBot ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: !query.byBot ? Theme.of(context).primaryColor.withOpacity(0.6) : Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(25)
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Text(
          query.query,
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 14,
            color: Colors.white
          ),
        ),
    ),
  );
}