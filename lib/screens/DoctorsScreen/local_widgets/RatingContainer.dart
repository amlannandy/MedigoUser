import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

Widget ratingContainer(BuildContext context, double rating) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      children: <Widget>[
        Icon(
          LineIcons.star,
          color: Colors.black.withOpacity(0.8),
          size: 15,
        ),
        SizedBox(width: 5),
        Text(
          rating.toStringAsFixed(1)
        ),
      ],
    ),
  );
}