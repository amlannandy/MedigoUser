import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Doctor.dart';
import '../models/Appointment.dart';
import '../widgets/MessagesStream.dart';
import '../services/AppointmentProvider.dart';
import '../services/UserDatabaseService.dart';

class ChatScreen extends StatelessWidget {

  final Appointment appointment;

  ChatScreen(this.appointment);

  final _textController = TextEditingController();
  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);
    
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: <Widget>[
          MessagesStream(appointment.id),
          inputField(context, user.uid),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black.withOpacity(0.7),
        ),
        onPressed: () => Navigator.of(context).pop()
      ),
      backgroundColor: Colors.white,
      title: Container(
        child: StreamBuilder<Doctor>(
          stream: userDatabaseService.streamDoctor(appointment.doctorId),
          builder: (context, snapshot) {
            final doctor = snapshot.data;
            if (doctor == null) {
              return Container();
            }
            return Row(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(doctor.imageUrl),
                    ),
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  doctor.name,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontFamily: 'Lato',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          }
        ),
      ),
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(
            LineIcons.gear,
            color: Colors.black.withOpacity(0.8),
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Report Doctor",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'Varela',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      bottom: PreferredSize(child: Container(color: Colors.black.withOpacity(0.8), height: 0.4,), preferredSize: Size.fromHeight(4.0)),
    );
  }

  Widget inputField(BuildContext context, String userId) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.8),
          width: 0.4
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 50,
                maxHeight: 100,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: TextField(
                  cursorColor: Colors.grey,
                  controller: _textController,
                  onSubmitted: (message) {
                    AppointmentProvider.sendMessage(appointment.id, userId, message);
                    _textController.clear();
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    hintText: 'Send a message',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Varela',
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              AppointmentProvider.sendMessage(appointment.id, userId, _textController.text);
              _textController.clear();
            },
            icon: Icon(
              LineIcons.chevron_circle_right,
              color: Colors.black.withOpacity(0.8),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}