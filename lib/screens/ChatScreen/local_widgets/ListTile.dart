import 'package:flutter/material.dart';

Widget listTile({ String title, String subtitle, IconData icon, Function onPress }) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300],
            width: 0.6
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black.withOpacity(0.8),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}