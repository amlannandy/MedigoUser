import 'package:flutter/material.dart';

class FeedbackField extends StatelessWidget {

  final String labelText;
  final TextEditingController controller;

  FeedbackField({
    @required this.controller,
    @required this.labelText,
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        minLines: 7,
        maxLines: 8,
        controller: controller,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}