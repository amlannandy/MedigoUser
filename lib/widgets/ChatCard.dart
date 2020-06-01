import 'package:Medigo/models/Message.dart';
import 'package:flutter/material.dart';

Widget chatCard(BuildContext context, Message chat) {
  return GestureDetector(
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
      border: Border(
        bottom: BorderSide(
          color: Colors.grey[300],
          width: 0.4,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 35.0,
              backgroundImage: AssetImage(chat.sender.imageUrl),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  chat.sender.name,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Varela',
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(
                    chat.text,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Varela',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              chat.time,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
              ),
            ),
            SizedBox(height: 5.0),
            chat.unread
                ? Container(
                    width: 40.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'NEW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                      ),
                    ),
                  )
                : Text(''),
          ],
        ),
      ],
    ),
  ),
);
}