import 'package:Medigo/screens/ConsulationsScreen/ConsulationsScreen.dart';
import 'package:Medigo/screens/DoctorsScreen/DoctorsListScreen.dart';
import 'package:flutter/material.dart';

import './local_widgets/CustomAppBar.dart';

class FiltersScreen extends StatelessWidget {

  final String category;
  
  const FiltersScreen(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, category),
      body: DoctorsListsScreen(),
    );
  }
}