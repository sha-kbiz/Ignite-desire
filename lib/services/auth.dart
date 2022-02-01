// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desire/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // create user obj based on firebase user
  CurrentUser? _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? CurrentUser(uid: user.uid) : null;
  }

  // auth change user stream
  //  Stream<User> get user {
  //   return _auth.authStateChanges()
  //     //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  //     .map(_userFromFirebaseUser);
  // }

  // sign in anon
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await FirebaseAuth.instance.signInAnonymously();
  //     FirebaseUser user = result.user as FirebaseUser;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = (await _auth.signInWithEmailAndPassword(
          email: email, password: password)) as AuthResult;
      FirebaseUser? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password)) as AuthResult;
      FirebaseUser? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

class _userFromFirebase {
  _userFromFirebase(Type user);
}

class FirebaseUser {
  get id => null;

  get uid => null;
}

class AuthResult {
  FirebaseUser? get user => null;
}

Future<void> userSetup(String name, phone, role) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();
  users.add({'Name': name, 'uid': uid, 'Phone': phone, 'Role': role});
}

Future<String> getCurrentUID() async {
  return (FirebaseAuth.instance.currentUser!).uid;
}
