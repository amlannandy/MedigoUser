import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import './SmallIconButton.dart';

class ConsultNowCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10
      ),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
        BoxShadow(
          color: Colors.grey[350],
          blurRadius: 20.0,
          spreadRadius: 0.02,
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Have any illness?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato'
                      ),
                    ),
                    Text(
                      "Tell us your symptoms",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato'
                      ),
                    ),
                  ],
                ),
                Text(
                  "We'll automatically assign a doctor to you",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                'assets/images/doctor.png',
                height: 120,
              ),
              smallIconButton(
                context,
                icon: LineIcons.play_circle_o,
                text: 'START',
                onPress: () => Navigator.of(context).pushNamed('/enquiry')
              ),
            ],
          ),
        ],
      ),
    );
  }
}