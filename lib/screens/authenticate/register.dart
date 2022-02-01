// ignore_for_file: deprecated_member_use, avoid_print
import 'dart:io';
import 'package:desire/screens/authenticate/signin.dart';
//import 'package:desire/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:desire/services/auth.dart';
//import 'package:flutter/src/widgets/form.dart';
import 'package:desire/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:desire/services/database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final databaseReference = FirebaseFirestore.instance;
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  String phone = '';
  String role = '';
  bool terms = true;
  String success = '';
  String location = '';
  String country = '';
  double lat = 10.1234567;
  double lng = 10.1234567;
  File? _pickedImage;
  String url = '';
  File? _validid;
  String idurl = '';

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //print(placemarks);
    Placemark place = placemarks[0];
    country = '${place.isoCountryCode}';
    lat = position.latitude;
    lng = position.longitude;
    setState(() => lat = lat);
    setState(() => lng = lng);
    // setState(() => country = country);
    // print('country: $country');
    // print(lat.runtimeType);
    // print('lng: $lng');
  }

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    Position position = await _getGeoLocationPosition();
    //print('country: $country');
    getAddressFromLatLong(position);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    final name = pickedImage.name;
    setState(() {
      _pickedImage = pickedImageFile;
    });
    setState(() {
      url = name;
    });
  }

  void _validId() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    final name = pickedImage.name;
    setState(() {
      _validid = pickedImageFile;
    });
    setState(() {
      idurl = name;
    });
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   final file = File(result.files.single.path);

    // } else {
    //   // User canceled the picker
    // }
  }

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Client',
      'label': 'Client',
    },
    {
      'value': 'Companion',
      'label': 'Companion',
    },
    {
      'value': 'Sugar Baby',
      'label': 'Sugar Baby',
    },
  ];

  Widget _imageView() {
    if (_pickedImage == null) {
      return const Text(
        'No file selected yet',
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      );
    } else {
      return CircleAvatar(
        radius: 40.0,
        backgroundImage: FileImage(_pickedImage!),
      );
    }
  }

  Widget _idView() {
    if (_validid == null) {
      return const Text(
        'No valid id selected yet',
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      );
    } else {
      return CircleAvatar(
        radius: 40.0,
        backgroundImage: FileImage(_validid!),
      );
    }
  }

  get color => null;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   backgroundColor: Colors.red,
            //   elevation: 0.0,
            //   title: const Text('Sign in'),
            // ),
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.black,
                    ],
                  )),
                  padding: const EdgeInsets.symmetric(
                      vertical: 100.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/logo.png',
                            width: 100, height: 100),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Email address",
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          obscureText: true,
                          validator: (val) => val!.length < 8
                              ? 'Password must be atleast 8 character..'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Phone Number (optional)",
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() => phone = val);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        _imageView(),
                        RaisedButton(
                          color: Colors.black,
                          child: const Text(
                            "Select Profile Pic",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _pickImageGallery,
                        ),
                        const SizedBox(height: 20.0),
                        _idView(),
                        RaisedButton(
                          color: Colors.black,
                          child: const Text(
                            "Select Valid id",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _validId,
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'You will be charged a monthly membership fee as to which option you as per below:',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                        //const SizedBox(height: 20.0),
                        SelectFormField(
                          style: const TextStyle(color: Colors.white),
                          type:
                              SelectFormFieldType.dropdown, // or can be dialog
                          initialValue: '',
                          labelText: 'Choose Type',
                          icon: const Visibility(
                              visible: false,
                              child: Icon(Icons.arrow_downward)),
                          items: _items,
                          validator: (val) =>
                              val!.isEmpty ? 'Please select role type' : null,
                          onChanged: (val) {
                            setState(() => role = val);
                          },
                        ),

                        const SizedBox(height: 20.0),
                        CheckboxListTileFormField(
                          title: const Text(
                            'By signing up you have read & agree to the privacy policy & the terms and conditions',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                          checkColor: Colors.white,
                          activeColor: Colors.red,
                          onSaved: (bool? value) {
                            //print(value);
                          },
                          validator: (bool? value) {
                            if (value!) {
                              return null;
                            } else {
                              return 'False!';
                            }
                          },
                          onChanged: (value) {
                            //print(value);
                          },
                        ),

                        const SizedBox(height: 30.0),
                        RaisedButton(
                            color: Colors.black,
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (country == 'IN') {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  try {
                                    //print(_pickedImage);
                                    final ref = FirebaseStorage.instance
                                        .ref()
                                        .child('usersImages')
                                        .child(url);
                                    await ref.putFile(_pickedImage!);
                                    url = await ref.getDownloadURL();
                                    final reff = FirebaseStorage.instance
                                        .ref()
                                        .child('usersImages')
                                        .child(url);
                                    await reff.putFile(_validid!);
                                    idurl = await reff.getDownloadURL();
                                    UserCredential userCredential =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: email,
                                                password: password);

                                    User? user = userCredential.user;
                                    await DatabaseService(uid: user!.uid)
                                        .updateUserData(role, email, phone, lat,
                                            lng, url, idurl);

                                    _auth.signOut();
                                    // setState(() => success =
                                    //     "Thank you for registering with us!  We will get back to you once we review your registration.");
                                    showDialog(
                                        context: context,
                                        builder: (_) => const AlertDialog(
                                              title: Text('Success'),
                                              content: Text(
                                                'Thank you for registering with us!  We will get back to you once we review your registration.',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ));
                                    setState(() => loading = false);
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print(
                                          'The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      setState(() => error =
                                          "The account already exists for that email.");
                                    }
                                    setState(() => loading = false);
                                  } catch (e) {
                                    //print('working fine');
                                  }
                                }
                              } else {
                                // setState(() => error =
                                //     "Sorry you can only Register if you are located within Canada");
                                showDialog(
                                    context: context,
                                    builder: (_) => const AlertDialog(
                                          title: Text('Alert'),
                                          content: Text(
                                            'Sorry you can only Register if you are located within Canada.',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ));
                              }
                            }),
                        const SizedBox(height: 12.0),
                        Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 14.0),
                        ),
                        Text(
                          success,
                          style: const TextStyle(
                              color: Colors.green, fontSize: 14.0),
                        ),
                        const SizedBox(height: 12.0),
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                        RaisedButton(
                            color: Colors.transparent,
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
