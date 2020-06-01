import 'package:flutter/material.dart';

class AppBarDeco extends StatelessWidget {

  final String title;

  AppBarDeco(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.only(
        left: 10,
        top: 15,
        bottom: 15,
      ),
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color.fromRGBO(248, 80, 50, 1), Color.fromRGBO(231, 56, 39, 1),],
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}