import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/LoadingSpinner.dart';
import './local_widgets/ConsulationsList.dart';

class ConsultationsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Container(
      child: user == null ? loadingSpinner(context) : consulationsList(context, user.uid)
    );
  }

  
}