// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
//import 'package:googleapis/people/v1.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;

/// The main widget of this demo.
class SignInDemo extends StatefulWidget {
  /// Creates the main widget of this demo.
  const SignInDemo({Key? key}) : super(key: key);

  @override
  State createState() => SignInDemoState();
}

/// The state of the main widget.
class SignInDemoState extends State<SignInDemo> {
  late GoogleSignIn _googleSignIn;
  late GoogleSignInAccount _currentUser;
  Future getUserContacts() async {
    final host = "https://people.googleapis.com";
    //final endPoint =
      //  "/v1/people/me/connections?personFields=names,phoneNumbers";
    final endPoint =
      "v1/users/othmanecr4@gmail.com/messages/4";
    final header = await _currentUser.authHeaders;
    print("loading contact");
    final request =
        await http.get(Uri.parse("$host$endPoint"), headers: header);
    print("Loading complete");
    if (request.statusCode == 200) {
      print("Api working perfect");
      print(request.body);
    } else {
      print("Api got errore");
      print(request.body);
    }
  }

  Widget getLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "See contact saved in your email",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
            onPressed: () async {
              try {
                await _googleSignIn.signIn();
              } on Exception catch (e) {
                print(e);
              }
            },
            child: Text("google sign in"),
            color: Colors.grey,
            textColor: Colors.white),
            
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn = GoogleSignIn(scopes: [
      //"https://www.googleapis.com/auth/contacts.readonly",
      "https://www.googleapis.com/auth/gmail.readonly",
      
    ]);

    _googleSignIn.onCurrentUserChanged.listen((user) {
      setState(() {
        _currentUser = user!;
        var photourl = _currentUser.photoUrl;
      });
      if (user != null) {
        getUserContacts();
      }
      print(_currentUser.email);
      print(_currentUser.photoUrl);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact App'),
      ),
      body: Column(
        children: [
          Center(child: getLoginWidget()),
          
        ],
      ),
    );
  }
}
