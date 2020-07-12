import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'local_widgets/CustomList.dart';
import '../../widgets/LoadingSpinner.dart';

class LockerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'MediLocker',
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'Lato',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),    
          ),
          bottom: TabBar(
            tabs: <Widget>[
              tabButton('Reports'),
              tabButton('Prescriptions'),
            ],
          ),
        ),
        body: user == null ? loadingSpinner(context) : TabBarView(
          children: <Widget> [
            CustomList(
              userId: user.uid,
              collectionName: 'medicalreports',
            ),
            CustomList(
              userId: user.uid,
              collectionName: 'prescriptions',
            ),
          ],
        ),
      ),
    );
  }

  Widget tabButton(String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontFamily: 'Lato',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),    
      ),
    );
  }
}