import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;

  PasswordField({
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
        color: Colors.deepOrange[50],
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: controller,
        obscureText: true,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: labelText,
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}