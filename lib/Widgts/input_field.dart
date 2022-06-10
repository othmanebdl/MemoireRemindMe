// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget widget;

  const InputField(
      {Key key,
       this.title,
       this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.only(left: 16),
              height: 52,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusedBorder: InputBorder.none,
                    ),
                  )),
                  widget == null ? Container() : Container(child: widget)
                ],
              ),
            )
          ],
        )
        );
  }
}
