// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:memoire/main.dart';
import 'package:testgoogle/main.dart';

class Profil extends StatelessWidget {
  const Profil({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: IconButton(
                    icon: const Icon(Icons.close, size: 40, color: Colors.red),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => Homepage()));
                    },)
      
      
    );
  }
}