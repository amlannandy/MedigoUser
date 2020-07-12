import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../widgets/CustomAppBar.dart';
import '../../../widgets/PrimaryButton.dart';
import '../local_widgets/FeedbackField.dart';
import '../../../services/AppointmentProvider.dart';

class FeedbackScreen extends StatefulWidget {

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  double _rating = 3;
  bool _problemSolved = false;
  bool _isAttentive = false;
  bool _fastResponse = false;

  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final apppointmentId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: customAppBar(context, 'Submit Feedback'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              upperText(),
              rating(),
              lowerText(),
              checkBoxes(),
              FeedbackField(
                controller: _feedbackController,
                labelText: 'Anything else?'
              ),
              PrimaryButton(
                text: 'SUBMIT', 
                press: () => AppointmentProvider.submitFeedback(
                  context: context,
                  appointmentId: apppointmentId,
                  rating: _rating,
                  other: _feedbackController.text,
                  isAttentive: _isAttentive,
                  problemSolved: _problemSolved,
                  fastResponse: _fastResponse,
                ), 
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget upperText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Text(
            "Thank you",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 24,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "for using our services",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Please give us a rating",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 20,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget lowerText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            "Tell us More",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget rating() {
    return RatingBar(
      itemSize: 30,
      unratedColor: Colors.grey[300],
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Theme.of(context).primaryColor.withOpacity(0.8),
      ),
      onRatingUpdate: (value) {
        _rating = value;
      },
    );
  }

  Widget checkBoxes() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 20
      ),
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text(
              "Your problem was solved",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 16,
                fontFamily: 'Lato'
              ),
            ),
            onChanged: (value) {
              setState(() => _problemSolved = !_problemSolved);
            },
            value: _problemSolved,
          ),
          CheckboxListTile(
            title: Text(
              "Doctor was attentive",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 16,
                fontFamily: 'Lato'
              ),
            ),
            onChanged: (value) {
              setState(() => _isAttentive = !_isAttentive);
            },
            value: _isAttentive,
          ),
          CheckboxListTile(
            title: Text(
              "Doctor response was fast",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 16,
                fontFamily: 'Lato'
              ),
            ),
            onChanged: (value) {
              setState(() => _fastResponse = !_fastResponse);
            },
            value: _fastResponse,
          ),
        ],
      ),
    );
  }
}