import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String role, String email, String phone,
      double lat, double lng, String url, String idurl) async {
    return await usersCollection.doc(uid).set({
      'role': role,
      'email': email,
      'phone': phone,
      'lat': lat,
      'lng': lng,
      'image': url,
      'vali_id': idurl
    });
  }

  Future<void> updateData(
      String name,
      String height,
      String weight,
      String gender,
      String ethnicity,
      String age,
      String city,
      String description) async {
    return await usersCollection.doc(uid).update({
      'name': name,
      'height': height,
      'weight': weight,
      'gender': gender,
      'ethnicity': ethnicity,
      'age': age,
      'city': city,
      'description': description,
    });
  }

  Future<void> updateProfile(String profile, String daterate,
      String measurements, String bodyType) async {
    return await usersCollection.doc(uid).update({
      'daterate': daterate,
      'measurements': measurements,
      'bodyType': bodyType,
    });
  }

  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }

  static Stream<QuerySnapshot> readItems() {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    return usersCollection.snapshots();
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    final DocumentReference<Map<String, dynamic>> usersCollection =
        FirebaseFirestore.instance.collection('users').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await usersCollection
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }
}
