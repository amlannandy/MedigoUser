import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../local_widgets/ChatAppBar.dart';
import '../../../models/Appointment.dart';
import '../local_widgets/InputField.dart';
import '../local_widgets/RecieveCall.dart';
import '../local_widgets/MessagesStream.dart';
import '../../../services/UserDatabaseService.dart';

class ChatScreen extends StatefulWidget {

  final Appointment appointment;

  ChatScreen(this.appointment);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _textController = TextEditingController();
  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  void initState() {
    getCameraAndMicPermission();
    super.initState();
  }

  void getCameraAndMicPermission() async {
    var status = await PermissionHandler().requestPermissions([PermissionGroup.camera, PermissionGroup.microphone]);
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppBar(context, widget.appointment.id, widget.appointment.doctorId),
      body: StreamBuilder<Appointment>(
        stream: userDatabaseService.streamAppointment(widget.appointment.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final appointment = snapshot.data;
            if (appointment.audioCallActive) {
              return RecieveCall(widget.appointment.id, appointment.channelId, true);
            }
            if (appointment.videoCallActive) {
              return RecieveCall(widget.appointment.id, appointment.channelId, false);
            }
          }
          return Column(
            children: <Widget>[
              MessagesStream(widget.appointment.id),
              inputField(
                context: context,
                controller: _textController,
                userId: widget.appointment.userId,
                appointmentId: widget.appointment.id,
              ),
            ],
          );
        }
      ),
    );
  }
}