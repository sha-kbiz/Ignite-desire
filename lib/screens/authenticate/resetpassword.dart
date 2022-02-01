// ignore: unused_import
// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:desire/screens/authenticate/authenticate.dart';
import 'package:desire/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:desire/loading.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   foregroundColor: Colors.white,
            //   backgroundColor: Colors.red,
            //   elevation: 0.0,
            //   title: const Text(
            //     'Reset password',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: const [
                  Colors.red,
                  Colors.black,
                ],
              )),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png',
                        width: 100, height: 100),
                    // CircleAvatar(
                    //   radius: 60.0,
                    //   backgroundImage: AssetImage("assets/images/logo.png"),
                    // ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Email address",
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.red,
                        child: Text(
                          "Reset password",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email)
                                  .then((value) => Navigator.of(context).pop());
                              //resetPassword(email);
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text(
                                          'Success',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        content: Text(
                                            'A Password reset link has been sent to $email'),
                                      ));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: Text(
                                            'Error',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: Text(
                                              'No user found for that email'),
                                        ));
                              }
                            }
                          }
                        })
                  ],
                ),
              ),
            ),
          );
  }
}
