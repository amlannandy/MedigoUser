import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Your Sessions',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}