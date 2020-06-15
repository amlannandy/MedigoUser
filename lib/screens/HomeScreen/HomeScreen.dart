import 'package:flutter/material.dart';

import './local_widgets/ChooseFieldCard.dart';
import './local_widgets/ConsultNowCard.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ChooseFieldCard(),
          ConsultNowCard(),
        ],
      ),
    );
  }
}