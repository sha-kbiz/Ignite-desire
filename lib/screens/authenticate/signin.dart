// ignore: unused_import
// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:desire/screens/authenticate/authenticate.dart';
import 'package:desire/screens/authenticate/register.dart';
import 'package:desire/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:desire/loading.dart';
import 'package:desire/screens/authenticate/resetpassword.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            //   backgroundColor: Colors.red,
            //   elevation: 0.0,
            //   title: const Text('Sign in'),
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
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Password",
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
                      obscureText: true,
                      validator: (val) => val!.length < 8
                          ? 'Password must be atleast 8 character..'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    TextButton(
                        child: Text(
                          "Forget password?",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword()),
                          );
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.black,
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() =>
                                error = "Please enter a valid credentials...");
                            loading = false;
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Not register yet?',
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                    RaisedButton(
                        color: Colors.transparent,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
  }
}
