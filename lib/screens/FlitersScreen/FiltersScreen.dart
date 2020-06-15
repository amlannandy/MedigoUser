import 'package:flutter/material.dart';

import './local_widgets/CustomAppBar.dart';
import '../../screens/DoctorsScreen/DoctorsListScreen.dart';

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