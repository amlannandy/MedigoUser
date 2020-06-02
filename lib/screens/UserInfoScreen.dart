import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/PrimaryButton.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/LightIconButton.dart';
import '../services/UserInfoProvider.dart';

const GOOGLE_API_KEY = 'AIzaSyDBVjfQa1q54VHunVlWzaUDOvTmdkqUzC0';

class UserInfoScreen extends StatefulWidget {

  static const routeName = '/userinfo';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {

  Position _currentPosition;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  void _getUserLocation() async {
    try {
      _currentPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${_currentPosition.latitude},${_currentPosition.longitude}&key=$GOOGLE_API_KEY';
      final response = await http.get(url);
      final data = json.decode(response.body);
      if (data != null) {
        print(data);
        final city = data['results'][0]['address_components'][4]['long_name'];
        setState(() => _locationController.text = city);
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              pictureContainer(context),
              SizedBox(height: 20),
              CustomTextField(
                icon: LineIcons.user,
                labelText: "Your Name",
                controller: _nameController,
              ),
              CustomTextField(
                icon: LineIcons.sort_numeric_asc,
                labelText: "Your Age",
                controller: _ageController,
                numeric: true,
              ),
              CustomTextField(
                icon: LineIcons.home,
                labelText: "Your Location",
                controller: _locationController,
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            child: PrimaryButton(
              text: "SUBMIT",
              press: () => UserInfoProvider.uploadUserInfo(
                context: context,
                name: _nameController.text,
                age: _ageController.text,
                location: _locationController.text,
                userPosition: _currentPosition,
              ),
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      )
    );
  }

  showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        titlePadding: const EdgeInsets.all(20),
        title: Text(
          "Upload Picture",
          style: TextStyle(
            fontFamily: 'Lato', 
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LightIconButton(
              icon: Icons.camera_alt,
              text: "Camera",
              function: () {
                UserInfoProvider.takePicture(context, () => {setState(() {})});
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LightIconButton(
              icon: Icons.filter,
              text: "Gallery",
              function: () {
                UserInfoProvider.uploadPicture(context, () => {setState(() {})});
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      )
    );
  }

  Widget pictureContainer(BuildContext context) {
    return Container(
      height: 270,
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: UserInfoProvider.currentImageUrl.isEmpty ? Icon(
              LineIcons.user, 
              size: 70,
              color: Colors.grey,
            ) : Container(),
            backgroundImage: UserInfoProvider.currentImageUrl.isEmpty ? null : NetworkImage(UserInfoProvider.currentImageUrl),
          ),
          InkWell(
            onTap: () {
              showUploadDialog(context);
            },
            child: Container(
              margin: const EdgeInsets.only(
                top: 15,
                bottom: 10,
              ),
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 15,
                right: 15,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25)
              ),
              child: Text(
                "Add Picture",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}