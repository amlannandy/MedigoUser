import 'dart:async';
import 'package:Medigo/services/AppointmentProvider.dart';
import 'package:flutter/material.dart';

class LoadiingScreen extends StatefulWidget {
  @override
  _LoadiingScreenState createState() => _LoadiingScreenState();
}

class _LoadiingScreenState extends State<LoadiingScreen> {

  Timer timer;
  int count = 8;

  @override
  void initState() {
    startTimer(context);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer(context) {
    timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => Future.delayed(Duration(milliseconds: 300), () {
        if (count == 1) {
          Navigator.of(context).pop();
          AppointmentProvider.createAppointment(context, 'yvWEQFTyJaRmEumEWE8wc08cuGf1');
        } else {
          count--;
        } 
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
            ),
            SizedBox(height: 15,),
            Text(
              'Finding suitable doctor for you...',
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 18,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}