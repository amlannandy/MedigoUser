import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/AppBarDeco.dart';
import '../widgets/CustomDrawer.dart';
import '../screens/HomeScreen.dart';
import '../screens/DoctorsListScreen.dart';
import '../screens/AppointmentsScreen.dart';

class ParentScreen extends StatefulWidget {

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  
  int _selectedIndex = 1;
  final _pageController = PageController(initialPage: 1);

  Map<String, Widget> _pages = {
    "Appointments" : AppointmentsScreen(),
    "Home" : HomeScreen(),
    "Doctors" : DoctorsListsScreen(),
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarDeco("MediGo"),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(LineIcons.bars),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: CustomDrawer(),
      body: PageView(
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        controller: _pageController,
        children: _pages.values.toList(),
      ),
      bottomNavigationBar: navBar(context),
    );
  }

  Widget navBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
        ]
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 5,
            activeColor: Theme.of(context).primaryColor,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Colors.white,
            tabs: [
              GButton(
                icon: LineIcons.history,
                text: 'Appointments',
                iconColor: Colors.white,
                onPressed: (index) => setState(() => _selectedIndex = index),
              ),
              GButton(
                icon: LineIcons.home,
                text: 'Home',
                iconColor: Colors.white,
                onPressed: (index) => setState(() => _selectedIndex = index),
              ),
              GButton(
                icon: LineIcons.users,
                text: 'Doctors',
                iconColor: Colors.white,
                onPressed: (index) => setState(() => _selectedIndex = index),
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
}