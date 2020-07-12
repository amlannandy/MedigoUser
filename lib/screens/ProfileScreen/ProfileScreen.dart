import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/MedigoUser.dart';
import '../../widgets/PrimaryButton.dart';
import '../../widgets/LoadingSpinner.dart';
import '../../services/UserInfoProvider.dart';
import './local_widgets/EditImageContainer.dart';
import '../../services/UserDatabaseService.dart';
import '../../widgets/CustomAppBar.dart';
import './local_widgets/EditField.dart';
import '../RegistrationScreens/local_widgets/LightIconButton.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  FirebaseUser user;
  MedigoUser medigoUser;
  final UserDatabaseService userDatabaseService = UserDatabaseService();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _cityController = TextEditingController();

  void updateValues() async {
    user = await FirebaseAuth.instance.currentUser();
    medigoUser = await userDatabaseService.getUser(user.uid);
    setState(() {
      _nameController.text = medigoUser.name;
      _ageController.text = medigoUser.age.toString();
      _heightController.text = medigoUser.height.toStringAsFixed(2);
      _weightController.text = medigoUser.weight.toStringAsFixed(2);
      _cityController.text = medigoUser.city;
      UserInfoProvider.currentImageUrl = medigoUser.imageUrl;
    });
  }

  @override
  void initState() {
    updateValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Edit Profile'),
      backgroundColor: Colors.white,
      body: medigoUser == null ? loadingSpinner(context) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            editImageContainer(
              context, 
              medigoUser.imageUrl, 
              () => showUploadDialog(context),
            ),
            editField(
              context: context,
              hinttext: 'Name',
              controller: _nameController,
              disabled: true,
            ),
            editField(
              context: context,
              hinttext: 'Age',
              controller: _ageController,
              disabled: false,
              keyboardtype: TextInputType.number,
            ),
            editField(
              context: context,
              hinttext: 'Height in cm',
              controller: _heightController,
              disabled: false,
              keyboardtype: TextInputType.number,
            ),
            editField(
              context: context,
              hinttext: 'Weight in kg',
              controller: _weightController,
              disabled: false,
              keyboardtype: TextInputType.number,
            ),
            editField(
              context: context,
              hinttext: 'City',
              controller: _cityController,
              disabled: false,
            ),
            SizedBox(height: 20),
            PrimaryButton(
              text: 'UPDATE',
              press: () => UserInfoProvider.updateUserInfo(
                context: context,
                userId: user.uid,
                age: _ageController.text,
                city: _cityController.text,
                height: _heightController.text,
                weight: _weightController.text,
              ),
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 10),
          ],
        ),
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
}