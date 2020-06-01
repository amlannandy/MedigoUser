import 'package:Medigo/widgets/ChatCard.dart';
import 'package:flutter/material.dart';
import '../models/Message.dart';

class AllChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (BuildContext context, int index) {
        return chatCard(context, chats[index]);
      },
    );
  }
}