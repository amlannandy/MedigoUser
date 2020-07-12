import 'package:Medigo/services/AppointmentProvider.dart';
import 'package:Medigo/widgets/LoadingSpinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './local_widgets/EnquiryAppBar.dart';
import './local_widgets/QuestionsStream.dart';
import './local_widgets/AnswerField.dart';
import '../../models/Query.dart';

class EnquiryScreen extends StatefulWidget {

  @override
  _EnquiryScreenState createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {

  final _answerController = TextEditingController();
  int currentIndex = 0;

  List<Query> queries = [
    Query(
      query: 'What are your symptoms?',
      byBot: true,
    ),
  ];

  List<Query> questions = [
    Query(
      query: 'For how many days have you been suffering from this?',
      byBot: true,
    ),
    Query(
      query: 'Have you consulted a doctor previously?',
      byBot: true,
    ),
    Query(
      query: 'Are you on a previous medicine dosage?',
      byBot: true,
    ),
    Query(
      query: 'Do you want to add anything else?',
      byBot: true,
    ),
    Query(
      query: 'Thank you!',
      byBot: true,
    ),
  ];

  void addAnswer(String text) {
    setState(() {
      queries.add(Query(
        query: text,
        byBot: false,
      ));
      addQuestion();
    });
  }

  void addQuestion() {
    if (currentIndex <= questions.length) {
      queries.add(questions[currentIndex]);
      currentIndex++;
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: enquiryAppBar(
        context, 
        'Please give us more details',
        user == null ? null : () => AppointmentProvider.uploadMedicalReport(userId: user.uid, queries: queries, context: context),
      ),
      body: user == null ? loadingSpinner(context) : Column(
        children: <Widget>[
          QuestionsStream(queries),
          answerField(
            context: context,
            controller: _answerController,
            onSend: addAnswer
          ),
        ],
      ),
    );
  }
}