import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

Widget buttonsRow() {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(
            LineIcons.comment,
            color: Colors.black.withOpacity(0.8),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            LineIcons.bar_chart,
            color: Colors.black.withOpacity(0.8),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            LineIcons.file_text_o,
            color: Colors.black.withOpacity(0.8),
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}