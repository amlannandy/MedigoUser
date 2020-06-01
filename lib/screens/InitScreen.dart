import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/MedigoUser.dart';
import '../services/UserDatabaseService.dart';

class InitScreen extends StatefulWidget {

  static const routeName = '/init';

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

  bool _redirect;
  String _redirectURL;

  Future<bool> _checkAuthStatus(BuildContext ctx) async {
    try {
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      if (currentUser == null) {
        _redirect = true;
        _redirectURL = "/login";
        return true;
      }
      print("Current User: $currentUser");
      print(currentUser.uid);
      UserDatabaseService databaseService = UserDatabaseService();
      MedigoUser user = await databaseService.getUser(currentUser.uid);
      if (user == null) {
        _redirect = true;
        _redirectURL = "/userinfo";
        return true;
      }
      if (user.emergencyContacts == null) {
        _redirect = true;
        _redirectURL = "/uploadcontacts";
        return true;
      }
      _redirectURL = "/home";
      _redirect = true;
      return true;

    } catch(err) {
      print(err);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromRGBO(248, 80, 50, 1), Color.fromRGBO(231, 56, 39, 1),],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  "MediGo",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                  ),
                ),
              ),
              FutureBuilder<bool>(
              future: _checkAuthStatus(context),
              builder: (BuildContext c, AsyncSnapshot<bool> snapshot) {
                List<Widget> children = [];
                if (snapshot.hasData && snapshot.data) {
                  print("InitState Returned: ${snapshot.data}");
                  new Future.delayed(Duration(milliseconds: 500), () {
                    print("Redirect: $_redirect $_redirectURL  |");
                    if (_redirect) {
                      Navigator.of(context).pushReplacementNamed(_redirectURL);
                    }
                  });
                  return Container();
                } 
                else if (snapshot.hasError) {
                  print(snapshot.error);
                  Text("Authentication Error",
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  );          
                }
                return Column(
                  children: children,              
                );
              },
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.lightGreen),
            ),  
          ],
        )
      ),
    );
  }
}