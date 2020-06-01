import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/MedigoUser.dart';
import '../services/UserInfoProvider.dart';
import '../services/UserDatabaseService.dart';

class CustomDrawer extends StatelessWidget {

  final UserDatabaseService userDatabaseService = UserDatabaseService();

  Widget userInfo(FirebaseUser user) {
    if (user != null) {
      return FutureProvider<MedigoUser>.value(
        value: userDatabaseService.getUser(user.uid),
        child: UserInfo(),
      );
    }
    return Container();
  }

  Widget buildListTitle({ String title, String subtitle="", IconData icon, BuildContext context, Function onClick }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Varela',
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontFamily: 'Varela',
          fontSize: 12,
          color: Colors.black38,
          fontWeight: FontWeight.w100
        ),
      ),
      onTap: onClick,
      dense: true,
    );
  }

  Widget getDivider(){
    return Divider(color: Colors.black45, thickness: 0.2,);
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          userInfo(user),
          Container(
            height: MediaQuery.of(context).size.height * 0.64,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildListTitle(
                    title: "Log out",
                    subtitle: "Exit your account",
                    icon: Icons.exit_to_app,
                    context: context,
                    onClick: () => UserInfoProvider.logOut(context),
                  ),
                  getDivider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MedigoUser>(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/profile'),
      child: Container(
        height: 140,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 20,
          left: 15,
        ),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
          ),
        ),
        child: user == null ? Container() : Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 7,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 37),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(0.5),
                  child: Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    )
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(2.5),
                  child: Text(
                    user.city,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
