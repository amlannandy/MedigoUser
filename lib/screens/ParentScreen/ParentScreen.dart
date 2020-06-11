import 'package:Medigo/screens/ParentScreen/local_widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../screens/HomeScreen/HomeScreen.dart';
import '../../screens/MenuScreen/MenuScreen.dart';
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
      bottomNavigationBar: navBar(context),
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