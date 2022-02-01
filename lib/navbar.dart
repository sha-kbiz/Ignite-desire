// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:desire/booking.dart';
import 'package:desire/homepage.dart';
import 'package:desire/services/auth.dart';
import 'package:desire/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

final AuthService _auths = AuthService();

class _NavbarState extends State<Navbar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 1;
  String _role = '';
  String _uid = '';

  @override
  void initState() {
    super.initState();
    getRole();
  }

  void getRole() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _role = snapshot['role'];
    });
  }

  static const List<Widget> _pages = <Widget>[Homepage(), Profile(), Booking()];
  static const List<Widget> _comppages = <Widget>[Booking(), Profile()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Profile'),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text('Booking'),
    )
  ];

  List<BottomNavigationBarItem> comp = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text('Booking'),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Profile'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text(
          'Ignite desire',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: const Icon(Icons.person, color: Colors.white),
            label: const Text('logout', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              await _auths.signOut();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red[400],
        selectedIconTheme: const IconThemeData(size: 30),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: _role == 'Client' ? items : comp,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        children: _role == 'Client' ? _pages : _comppages,
        index: _selectedIndex,
      ),
    );
  }
}
