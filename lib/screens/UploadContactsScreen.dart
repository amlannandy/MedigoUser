import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_contact_picker/easy_contact_picker.dart';
import 'package:provider/provider.dart';

import '../widgets/AppBarDeco.dart';
import '../widgets/SuccessButton.dart';
import '../services/UserInfoProvider.dart';

class UploadContactsScreen extends StatefulWidget {

  static const routeName = '/uploadcontacts';

  @override
  _UploadContactsScreenState createState() => _UploadContactsScreenState();
}

class _UploadContactsScreenState extends State<UploadContactsScreen> {

  List selectedContacts = [];

  Map<String, String> _contacts = Map();
  Map<String, String> _search = Map();
  Map<String, bool> _selected = Map();

  final EasyContactPicker _contactPicker = new EasyContactPicker();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _openAddressBook();
  }

  void filterSearchResults(String query) {
    Map<String, String> dummySearchList = Map();
    dummySearchList.addAll(_search);
    print(query);
    if(query.isNotEmpty) {
      Map<String, String> dummyListData = Map();
      dummySearchList.forEach((key, value) {
        if(value.toLowerCase().contains(query.toLowerCase())) {
          dummyListData[key] = value;
        }
      });
      setState(() {
        _contacts.clear();
        _contacts.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _contacts.clear();
        _contacts.addAll(_search);
      });
    }
  }

  Widget _getItemWithIndex(String contact) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20, right: 20),
      selected: _selected[contact] == true,
      title: Text(_contacts[contact]),
      subtitle: Container(
        child: Text(contact),
      ),
      trailing: Icon(_selected[contact] == true?Icons.check_box:Icons.check_box_outline_blank),
      onTap: () {
        setState(() {
          if (_selected[contact] != null)
            _selected[contact] = !_selected[contact];
          else
            _selected[contact] = true;
        });
        selectedContacts.add(contact);
      },
    );
  }

  _openAddressBook() async{
    await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
    if (permission == PermissionStatus.granted){
      _getContactData();
    }
  }

  _getContactData() async{
    final RegExp _phoneRegExp = new RegExp(r'^\+91[0-9]{10}$');
    final RegExp _phoneRegExp1 = new RegExp(r'^[0-9]{10}$');

    List<Contact> list = await _contactPicker.selectContacts();
    Map<String, String> _temp = Map();

    list.forEach((Contact contact) {
      String phoneNumber = contact.phoneNumber.split(" ").join("");
      if (_phoneRegExp1.hasMatch(phoneNumber)) {
        phoneNumber = "+91$phoneNumber";
      }
      if (!_temp.containsKey(phoneNumber) && _phoneRegExp.hasMatch(phoneNumber)) {
        _temp[phoneNumber] = contact.fullName;
      }
    });

    setState(() {
      _contacts = _temp;
      _search.addAll(_contacts);
    });
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        flexibleSpace: AppBarDeco("Update Emergency Contacts"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Varela',
                ),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                contentPadding: const EdgeInsets.only(
                  top: 5,
                )
              ),
              onChanged: (value) {
                filterSearchResults(value);
              },
            ),
          ),
          Divider(color: Colors.grey, thickness: 0.4),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.67,
            child: ListView.builder(
              itemBuilder: (context, index) {
                String key = _contacts.keys.elementAt(index);
                return _getItemWithIndex(key);
              },
              itemCount: _contacts.length,
            ),
          ),
          Divider(color: Colors.grey, thickness: 0.4),
          SuccessButton(
            text: "Save Contacts",
            icon: Icons.save,
            onPress: () {
              Set<String> unique =  Set.from(selectedContacts);
              selectedContacts = unique.toList();
              UserInfoProvider.updateEmergencyContacts(context, user.uid, selectedContacts);
            }
          ),
        ],
      ),
    );
  }
}
