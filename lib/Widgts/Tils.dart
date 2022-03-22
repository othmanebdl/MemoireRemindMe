// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  const Tiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('go shopping',
      style: TextStyle(
          fontSize:25,
          fontFamily: 'Raleway',
          color: Colors.white,
          fontWeight: FontWeight.w700
      ),),
      trailing: Checkbox(
        value: false,
        onChanged:null,
      ),
    );
  }
}