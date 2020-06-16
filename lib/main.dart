import 'package:Medigo/screens/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/InitScreen.dart';
import './screens/ParentScreen/ParentScreen.dart';
import './screens/EnquiryScreen/EnquiryScreen.dart';
import './screens/ProfileScreen/ProfileScreen.dart';
import './screens/MenuScreen/screens/WebViewScreen.dart';
import './screens/RegistrationScreens/screens/LoginScreen.dart';
import './screens/RegistrationScreens/screens/UserInfoScreen.dart';
import './screens/RegistrationScreens/screens/PasswordResetScreen.dart';
import './screens/RegistrationScreens/screens/EmailVerificationScreen.dart';

void main() => runApp(MedigoApp());

class MedigoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff581b98),
          accentColor: Colors.purple[200],
          textTheme: TextTheme(
            headline6: TextStyle(
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
          '/parent' : (ctx) => ParentScreen(),
          '/profile' : (ctx) => ProfileScreen(),
          '/emailverification' : (ctx) => EmailVerificationScreen(),
          '/passwordreset' : (ctx) => PasswordResetScreen(),
          '/enquiry' : (ctx) => EnquiryScreen(),
          '/webview' : (ctx) => WebViewScreen(),
          '/loading': (ctx) => LoadiingScreen(),
        },
      ),
    );
  }
}