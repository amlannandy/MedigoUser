import 'package:Medigo/screens/FlitersScreen/FiltersScreen.dart';
import 'package:flutter/material.dart';

import './DoctorFieldButton.dart';

class ChooseFieldCard extends StatelessWidget {

  final List categories = [
    'General',
    'Dermatology',
    'Pediatrics',
    'Pathology',
    'Oncology',
    'Radiology',
    'Urology',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
        BoxShadow(
          color: Colors.grey[350],
          blurRadius: 20.0,
          spreadRadius: 0.02,
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.275,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/images/doctors.jpg',
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.8),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Consult our Specialists',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            child: GridView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1/3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
              ),
              children: <Widget>[
                for (var category in categories) doctorFieldButton(
                  context,
                  text: category,
                  onPress: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => FiltersScreen(category),
                  ))
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}