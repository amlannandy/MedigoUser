import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/ChatAppBar.dart';
import '../models/Appointment.dart';
import '../widgets/InputField.dart';
import '../widgets/MessagesStream.dart';

class ChatScreen extends StatefulWidget {

  final Appointment appointment;

  ChatScreen(this.appointment);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _textController = TextEditingController();

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
      body: Column(
        children: <Widget>[
          MessagesStream(widget.appointment.id),
          inputField(
            context: context,
            controller: _textController,
            userId: widget.appointment.userId,
            appointmentId: widget.appointment.id,
          ),
        ],
      ),
    );
  }
}