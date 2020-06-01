import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/InitScreen.dart';
import './screens/LoginScreen.dart';
import './screens/HomeScreen.dart';
import './screens/ProfileScreen.dart';
import './screens/UserInfoScreen.dart';
import './screens/UploadContactsScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color.fromRGBO(248, 80, 50, 1),
          accentColor: Color.fromRGBO(231, 56, 39, 1),
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: 'Lato',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        initialRoute: '/init',
        routes: {
          '/init' : (ctx) => InitScreen(),
          '/login' : (ctx) => LoginScreen(),
          '/userinfo' : (ctx) => UserInfoScreen(),
          '/uploadcontacts' : (ctx) => UploadContactsScreen(),
          '/home' : (ctx) => HomeScreen(),
          '/profile' : (ctx) => ProfileScreen(),
        },
      ),
    );
  }
}