import 'package:flutter/material.dart';

import '../../../services/AppointmentProvider.dart';
import '../../../widgets/PrimaryButton.dart';

class RecieveCall extends StatelessWidget {

  final String appointmentId;
  final String channelId;
  final bool audioOnly;

  const RecieveCall(this.appointmentId, this.channelId, this.audioOnly);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Doctor wants to connect with you',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Lato',
              fontSize: 20,
            ),
          ),
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.black.withOpacity(0.8)
              ),
              children: [
                TextSpan(
                  text: 'via',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                  )
                ),
                TextSpan(
                  text: '  ',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 18,
                  )
                ),
                TextSpan(
                  text: audioOnly ? 'Audio' : 'Video',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 36,
                  )
                ),
              ]
            )
          ),
          SizedBox(height: 20,),
          PrimaryButton(
            text: 'RECIEVE',
            color: Theme.of(context).primaryColor,
            press: audioOnly ? 
            () => AppointmentProvider.joinAudioCall(context, appointmentId, channelId)
            : () =>AppointmentProvider.joinVideoCall(context, appointmentId, channelId)
          )
        ],
      ),
    );
  }
}