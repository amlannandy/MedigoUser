import 'package:flutter/material.dart';

class DataInput extends StatelessWidget {

  final TextEditingController controller;
  final bool disabled;

  DataInput(this.controller, { this.disabled = false });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        enabled: !disabled,
        controller: controller,
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontFamily: 'Lato',
          fontSize: 18,
        ),
        maxLines: null,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none
        ),
      ),
    );
  }
}