import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../models/Doctor.dart';
import '../../../widgets/CustomText.dart';
import '../../../services/AppointmentProvider.dart';

Widget doctorCard(BuildContext context, Doctor doctor) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(
      top: 15,
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
    ),
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
      children: <Widget>[
        profileRow(doctor),
        buttonsRow(context, doctor),
      ],
    ),
  );
}

Widget profileRow(Doctor doctor) {
  return Padding(
    padding: const EdgeInsets.all(25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(doctor.imageUrl),
              fit: BoxFit.cover
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    'Dr. ' + doctor.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Varela',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  doctor.field,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Varela',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: RatingBar(
                allowHalfRating: true,
                itemSize: 30,
                initialRating: 3,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.3),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Theme.of(context).accentColor,
                ),
                onRatingUpdate: null,
              )
            )
          ],
        )
      ],
    ),
  );
}

Widget buttonsRow(BuildContext context, Doctor doctor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      lightButton(context, doctor),
      darkButton(context, doctor),
    ],
  );
}

Widget lightButton(BuildContext context, Doctor doctor) {
  return InkWell(
    onTap: () => AppointmentProvider.createAppointment(context, doctor.userId),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15)
        ),
        color: Theme.of(context).accentColor.withOpacity(0.2),
      ),
      child: CustomText(
        text: "Book Session",
        size: 18,
        color: Theme.of(context).primaryColor,
      ),
    ),
  );
}

Widget darkButton(BuildContext context, Doctor doctor) {
  return InkWell(
    onTap: () {},
    child: Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15)
        ),
        color: Theme.of(context).primaryColor.withOpacity(0.9),
      ),
      child: CustomText(
        text: "View Profile",
        size: 18,
        color: Colors.white,
      ),
    ),
  );
}
