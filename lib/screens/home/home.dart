// ignore_for_file: deprecated_member_use, unnecessary_new

import 'package:desire/services/auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

final CollectionReference userRef =
    FirebaseFirestore.instance.collection('Users');

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  //String uid = '';
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Ignite desire'),
          backgroundColor: Colors.red[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex, //New
          backgroundColor: Colors.red,
          //selectedIconTheme: const IconThemeData(size: 40),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text('Booking'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            )
          ],
        ),
        body: const ProfileData());
  }
}

class ProfileData extends StatefulWidget {
  const ProfileData({Key? key}) : super(key: key);

  @override
  _ProfileDataState createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  final Location location = Location();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid = '';
  String _role = '';
  String _phone = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    getData();
    //_getUserName();
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _role = snapshot['role'];
      _phone = snapshot['phone'];
      _email = snapshot['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Column(
        children: [
          Text('email: $_email'),
          Text('role: $_role'),
          Text('phone: $_phone'),
          RaisedButton(
              color: Colors.red,
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              })
        ],
      ),
    );
  }
}
