import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import './local_widgets/CustomAppBar.dart';
import '../../screens/HomeScreen/HomeScreen.dart';
import '../../screens/MenuScreen/screens/MenuScreen.dart';
import '../../screens/DoctorsScreen/DoctorsListScreen.dart';
import '../../screens/ConsulationsScreen/ConsulationsScreen.dart';

class ParentScreen extends StatefulWidget {

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  
  int _selectedIndex = 0;
  final _pageController = PageController(initialPage: 0);

  Map<String, Widget> _pages = {
    "Home" : HomeScreen(),
    "Sessions" : ConsultationsScreen(),
    "Doctors" : DoctorsListsScreen(),
    "Menu" : MenuScreen(),
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: customAppBar(context, userId),
      body: PageView(
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        controller: _pageController,
        children: _pages.values.toList(),
      ),
      bottomNavigationBar: googleNavBar(context),
    );
  }

  Widget googleNavBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
      ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 5,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Theme.of(context).primaryColor,
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.history,
                text: 'Chats',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.users,
                text: 'Doctors',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              GButton(
                icon: LineIcons.bars,
                text: 'Menu',
                iconColor: Theme.of(context).primaryColor,
                onPressed: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              );
              setState(() {
                _selectedIndex = index;
              });
            }
          ),
        ),
      ),
    );
  }

  Widget navBar(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(49.75),
                topRight: Radius.circular(49.75),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.0995,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 20,
                currentIndex: _selectedIndex,
                onTap: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                  setState(() => _selectedIndex = index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      LineIcons.home,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    backgroundColor: Colors.white,
                    title: Text(
                      _pages.keys.elementAt(0),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: 'Lato',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      LineIcons.history,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    backgroundColor: Colors.white,
                    title: Text(
                      _pages.keys.elementAt(1),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: 'Lato',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      LineIcons.users,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    backgroundColor: Colors.white,
                    title: Text(
                      _pages.keys.elementAt(2),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: 'Lato',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      LineIcons.bars,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    backgroundColor: Colors.white,
                    title: Text(
                      _pages.keys.elementAt(3),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: 'Lato',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}