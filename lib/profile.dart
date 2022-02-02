import 'dart:io';

import 'package:flutter/material.dart';
import 'package:desire/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:desire/services/database.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:desire/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

//final AuthService _auths = AuthService();
final _formKey = GlobalKey<FormState>();

class _ProfileState extends State<Profile> {
  final Location location = Location();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getData();
    //_getUserName();
  }

  bool loading = false;
  String _uid = '';
  String _role = '';
  // ignore: unused_field
  String _phone = '';
  // ignore: unused_field
  String _email = '';
  String _name = '';
  String _height = '';
  String _weight = '';
  String _gender = '';
  String _ethnicity = '';
  String _age = '';
  String _city = '';
  String _description = '';
  File? _profile;
  // ignore: non_constant_identifier_names
  String profile_url = '';
  String daterate = '';
  String measurements = '';
  String bodyType = '';
  // ignore: non_constant_identifier_names
  String profile_db = '';

  void _pickProfile() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    final name = pickedImage.name;
    setState(() {
      _profile = pickedImageFile;
    });
    setState(() {
      profile_url = name;
    });
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
      _name = snapshot['name'];
      _height = snapshot['height'];
      _weight = snapshot['weight'];
      _gender = snapshot['gender'];
      _ethnicity = snapshot['ethnicity'];
      _age = snapshot['age'];
      _city = snapshot['city'];
      _description = snapshot['description'];
      profile_db = snapshot['profile'];
      daterate = snapshot['daterate'];
      measurements = snapshot['measurements'];
      bodyType = snapshot['bodyType'];
    });
  }

  Widget _profileView() {
    // ignore: unnecessary_null_comparison
    if (profile_url != null && _profile == null) {
      return CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(profile_db),
      );
    } else if (_profile == null) {
      return const CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.black,
      );
    } else {
      return CircleAvatar(
        radius: 50.0,
        backgroundImage: FileImage(_profile!),
      );
    }
  }

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Heterosexual male',
      'label': 'Heterosexual male',
    },
    {
      'value': 'Heterosexual female',
      'label': 'Heterosexual female',
    },
    {
      'value': 'Transgender',
      'label': 'Transgender',
    },
    {
      'value': 'Gay male',
      'label': 'Gay female',
    },
    {
      'value': 'Gay female',
      'label': 'Gay female',
    },
    {
      'value': 'Bisexual female',
      'label': 'Bisexual female',
    },
    {
      'value': 'Bisexual male',
      'label': 'Bisexual male',
    },
  ];
  final List<Map<String, dynamic>> ethnicity = [
    {
      'value': 'Caucasian',
      'label': 'Caucasian',
    },
    {
      'value': 'African American',
      'label': 'African American',
    },
    {
      'value': 'Asian',
      'label': 'Asian',
    },
    {
      'value': 'Hispanic',
      'label': 'Hispanic',
    },
    {
      'value': 'Middle Eastern',
      'label': 'Middle Eastern',
    },
    {
      'value': 'First Nations',
      'label': 'First Nations',
    },
    {
      'value': 'East Indian',
      'label': 'East Indian',
    },
    {
      'value': 'Other',
      'label': 'Other',
    },
    {
      'value': 'Rather not Say',
      'label': 'Rather not Say',
    },
  ];
  final List<Map<String, dynamic>> _cities = [
    {
      'value': 'Barrie',
      'label': 'Barrie',
    },
    {
      'value': 'Calgary',
      'label': 'Calgary',
    },
    {
      'value': 'Edmonton',
      'label': 'Edmonton',
    },
    {
      'value': 'GTA',
      'label': 'GTA',
    },
    {
      'value': 'Guelph',
      'label': 'Guelph',
    },
    {
      'value': 'Halifax',
      'label': 'Halifax',
    },
    {
      'value': 'Hamilton',
      'label': 'Hamilton',
    },
    {
      'value': 'Kingston',
      'label': 'Kingston',
    },
    {
      'value': 'London',
      'label': 'London',
    },
    {
      'value': 'Montreal',
      'label': 'Montreal',
    },
    {
      'value': 'Niagara Region',
      'label': 'Niagara Region',
    },
    {
      'value': 'Oshawa',
      'label': 'Oshawa',
    },
    {
      'value': 'Ottawa',
      'label': 'Ottawa',
    },
    {
      'value': 'Price Edward Island',
      'label': 'Price Edward Island',
    },
    {
      'value': 'Quebec City',
      'label': 'Quebec City',
    },
    {
      'value': 'Saskatoon',
      'label': 'Saskatoon',
    },
    {
      'value': 'Sault Ste. Marie',
      'label': 'Sault Ste. Marie',
    },
    {
      'value': "St. John's",
      'label': "St. John's",
    },
    {
      'value': 'Sudbury',
      'label': 'Sudbury',
    },
    {
      'value': 'Toronto',
      'label': 'Toronto',
    },
    {
      'value': 'Thunder Bay',
      'label': 'Thunder Bay',
    },
    {
      'value': 'Vancouver',
      'label': 'Vancouver',
    },
    {
      'value': 'Winnipeg',
      'label': 'Winnipeg',
    },
    {
      'value': 'Windsor',
      'label': 'Windsor',
    },
  ];
  final List<Map<String, dynamic>> body = [
    {
      'value': 'Curvy',
      'label': 'Curvy',
    },
    {
      'value': 'Slim',
      'label': 'Slim',
    },
    {
      'value': 'Athletic',
      'label': 'Athletic',
    },
    {
      'value': 'Fit',
      'label': 'Fit',
    },
    {
      'value': 'Plus size',
      'label': 'Plus size',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(

                //padding:
                // const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                // child: Column(
                //   children: [
                //     Text('email: $_email'),
                //     Text('role: $_role'),
                //     Text('phone: $_phone'),
                //     RaisedButton(
                //         color: Colors.red,
                //         child: const Text(
                //           "Logout",
                //           style: TextStyle(color: Colors.white),
                //         ),
                //         onPressed: () async {
                //           await _auth.signOut();
                //         })
                //   ],
                // ),
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
                          vertical: 30.0, horizontal: 30.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(height: 20.0),

                                // ignore: deprecated_member_use
                                // RaisedButton(
                                //   color: Colors.black,
                                //   elevation: 0,
                                //   child: _profileView(),
                                //   onPressed: _pickProfile,
                                // ),
                                OutlinedButton(
                                  onPressed: _pickProfile,
                                  child: _profileView(),
                                  style: OutlinedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(0),
                                  ),
                                ),

                                const SizedBox(height: 20.0),
                                TextFormField(
                                  // controller: TextEditingController()
                                  //   ..text = _name,
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text: _name,
                                          selection: TextSelection.collapsed(
                                              offset: _name.length))),
                                  style: const TextStyle(color: Colors.white),
                                  //initialValue: _name,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    fillColor: Colors.grey[800],
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() => _name = val);
                                  },
                                ),

                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        // controller: TextEditingController()
                                        //   ..text = _height,
                                        controller:
                                            TextEditingController.fromValue(
                                                TextEditingValue(
                                                    text: _height,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: _height
                                                                .length))),
                                        decoration: InputDecoration(
                                          labelText: "Height",
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          fillColor: Colors.grey[800],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        onChanged: (val) {
                                          setState(() => _height = val);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20, height: 20),
                                    Flexible(
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller:
                                            TextEditingController.fromValue(
                                                TextEditingValue(
                                                    text: _weight,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: _weight
                                                                .length))),
                                        decoration: InputDecoration(
                                          labelText: "Weight",
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          fillColor: Colors.grey[800],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        onChanged: (val) {
                                          setState(() => _weight = val);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20, height: 20),
                                    Flexible(
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller:
                                            TextEditingController.fromValue(
                                                TextEditingValue(
                                                    text: _age,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset:
                                                                _age.length))),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: "Age",
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          fillColor: Colors.grey[800],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        onChanged: (val) {
                                          setState(() => _age = val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(children: <Widget>[
                                  Flexible(
                                    child: SelectFormField(
                                      controller: TextEditingController()
                                        ..text = _gender,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog

                                      labelText: 'Identifies as',
                                      //labelStyle: const TextStyle(color: Colors.white),
                                      icon: const Visibility(
                                          visible: false,
                                          child: Icon(Icons.arrow_downward)),
                                      items: _items,
                                      validator: (val) => val!.isEmpty
                                          ? 'Please select gender'
                                          : null,
                                      onChanged: (val) {
                                        setState(() => _gender = val);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 20, height: 20),
                                  Flexible(
                                    child: SelectFormField(
                                      controller: TextEditingController()
                                        ..text = _ethnicity,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog

                                      labelText: 'Ethnicity',
                                      //labelStyle: const TextStyle(color: Colors.white),
                                      icon: const Visibility(
                                          visible: false,
                                          child: Icon(Icons.arrow_downward)),
                                      items: ethnicity,
                                      validator: (val) => val!.isEmpty
                                          ? 'Please select ethnicity'
                                          : null,
                                      onChanged: (val) {
                                        setState(() => _ethnicity = val);
                                      },
                                    ),
                                  )
                                ]),
                                const SizedBox(height: 20.0),
                                SelectFormField(
                                  controller: TextEditingController()
                                    ..text = _city,
                                  style: const TextStyle(color: Colors.white),
                                  type: SelectFormFieldType
                                      .dropdown, // or can be dialog

                                  labelText: 'Located',
                                  //labelStyle: const TextStyle(color: Colors.white),
                                  //icon: const Visibility(
                                  //visible: false,
                                  //child: Icon(Icons.arrow_downward)),
                                  items: _cities,
                                  validator: (val) => val!.isEmpty
                                      ? 'Please select city'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => _city = val);
                                  },
                                ),

                                const SizedBox(height: 20.0),
                                if (_role == "Sugar Baby")
                                  SelectFormField(
                                    controller: TextEditingController()
                                      ..text = bodyType,
                                    style: const TextStyle(color: Colors.white),
                                    type: SelectFormFieldType
                                        .dropdown, // or can be dialog
                                    labelText: 'Body Type',
                                    //labelStyle: const TextStyle(color: Colors.white),
                                    //icon: const Visibility(
                                    //visible: false,
                                    //child: Icon(Icons.arrow_downward)),
                                    items: body,
                                    validator: (val) => val!.isEmpty
                                        ? 'Please select body type'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => bodyType = val);
                                    },
                                  )
                                else
                                  const SizedBox(height: 20.0),
                                if (_role == "Sugar Baby")
                                  Row(children: <Widget>[
                                    Flexible(
                                        child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      controller:
                                          TextEditingController.fromValue(
                                              TextEditingValue(
                                                  text: daterate,
                                                  selection:
                                                      TextSelection.collapsed(
                                                          offset: daterate
                                                              .length))),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Date rate",
                                        labelStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        fillColor: Colors.grey[800],
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      onChanged: (val) {
                                        setState(() => daterate = val);
                                      },
                                    )),
                                    const SizedBox(width: 20, height: 20),
                                    Flexible(
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller:
                                            TextEditingController.fromValue(
                                                TextEditingValue(
                                                    text: measurements,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: measurements
                                                                .length))),
                                        decoration: InputDecoration(
                                          labelText: "Measurements",
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          fillColor: Colors.grey[800],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        onChanged: (val) {
                                          setState(() => measurements = val);
                                        },
                                      ),
                                    )
                                  ])
                                else
                                  const SizedBox(height: 0.0),
                                if (_role == "Companion")
                                  Row(children: <Widget>[
                                    Flexible(
                                        child: SelectFormField(
                                      controller: TextEditingController()
                                        ..text = bodyType,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      type: SelectFormFieldType
                                          .dropdown, // or can be dialog
                                      labelText: 'Body Type',
                                      //labelStyle: const TextStyle(color: Colors.white),
                                      //icon: const Visibility(
                                      //visible: false,
                                      //child: Icon(Icons.arrow_downward)),
                                      items: body,
                                      validator: (val) => val!.isEmpty
                                          ? 'Please select body type'
                                          : null,
                                      onChanged: (val) {
                                        setState(() => bodyType = val);
                                      },
                                    )),
                                    const SizedBox(width: 20, height: 20),
                                    Flexible(
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller:
                                            TextEditingController.fromValue(
                                                TextEditingValue(
                                                    text: measurements,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: measurements
                                                                .length))),
                                        decoration: InputDecoration(
                                          labelText: "Measurements",
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          fillColor: Colors.grey[800],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        onChanged: (val) {
                                          setState(() => measurements = val);
                                        },
                                      ),
                                    )
                                  ])
                                else
                                  const SizedBox(height: 0.0),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                          text: _description,
                                          selection: TextSelection.collapsed(
                                              offset: _description.length))),
                                  style: const TextStyle(color: Colors.white),
                                  //initialValue: 'qwert',
                                  maxLines: 5,
                                  //keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    labelText: "About Me",
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    fillColor: Colors.grey[800],
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() => _description = val);
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                // ignore: deprecated_member_use
                                RaisedButton(
                                    color: Colors.red,
                                    child: const Text(
                                      "Update Profile",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() => loading = true);
                                        if (_profile != null) {
                                          final ref = FirebaseStorage.instance
                                              .ref()
                                              .child('profile')
                                              .child(profile_url);
                                          await ref.putFile(_profile!);
                                          profile_url =
                                              await ref.getDownloadURL();
                                        }
                                        print('test: $profile_url');
                                        await DatabaseService(uid: _uid)
                                            .updateData(
                                                _name,
                                                _height,
                                                _weight,
                                                _gender,
                                                _ethnicity,
                                                _age,
                                                _city,
                                                _description);
                                        await DatabaseService(uid: _uid)
                                            .updateProfile(
                                                profile_url,
                                                daterate,
                                                measurements,
                                                bodyType);
                                      }
                                      setState(() => loading = false);
                                      showDialog(
                                          context: context,
                                          builder: (_) => const AlertDialog(
                                                title: Text('Success'),
                                                content: Text(
                                                    'Profile has been updated successfully.'),
                                              ));
                                    })
                              ])),
                    ))));
  }
}
