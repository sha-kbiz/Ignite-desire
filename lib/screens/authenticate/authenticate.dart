//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desire/screens/authenticate/signin.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:desire/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return const SignIn();
  }
}

// @override
// Future<void> resetPassword(String email) async {
//   try {
//     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }
