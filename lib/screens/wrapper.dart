//import 'package:desire/models/user.dart';
import 'package:desire/screens/authenticate/authenticate.dart';
import 'package:desire/screens/home/home.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return const Authenticate();
        }
      },
    );

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

class user {}
