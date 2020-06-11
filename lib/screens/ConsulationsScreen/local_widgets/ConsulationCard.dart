import 'package:flutter/material.dart';

import '../local_widgets/ButtonsRow.dart';
import '../../../models/Appointment.dart';
import '../local_widgets/ChatCard.dart';

class ConsultationCard extends StatelessWidget {

  final Appointment appointment;

  ConsultationCard(this.appointment);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
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
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 0.4,
        )
      ),
      child: Column(
        children: <Widget>[
          chatCard(context, appointment),
          Divider(color: Colors.grey, thickness: 0.4, height: 0.4),
          buttonsRow(),
        ],
      ),
    );
  }

}