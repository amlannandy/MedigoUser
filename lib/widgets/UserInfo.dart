import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/MedigoUser.dart';
import '../services/UserDatabaseService.dart';

class UserInfo extends StatelessWidget {

  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    print(MediaQuery.of(context).size.height);

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: user == null ? Container() : StreamBuilder<MedigoUser>(
        stream: userDatabaseService.streamUser(user.uid),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            return Container();
          }
          final user = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.imageUrl),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              SizedBox(height: 10),
              Text(
                user.name,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 5),
              Text(
                user.city,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontFamily: 'Lato',
                ),
              ),
              SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }
}