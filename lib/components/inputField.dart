import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class InputField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String hintText;
  const InputField({Key? key, this.onChanged, required this.controller, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
    CupertinoTextField(
      clearButtonMode: OverlayVisibilityMode.editing,
    )
        :
    Container(
      margin: EdgeInsets.all(20.0),
      child: Stack(
        children: [
          TextField(
            onChanged: this.onChanged,
            controller: this.controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(), // OutlineInputBorder
                hintText: this.hintText,
                counterText: ""
            ),
            maxLength: 10,
          ),
          Positioned(
              right: 0,
              top: 0,
              bottom:0,
              child: IconButton(icon: Icon(Icons.close), onPressed: (){},)
          )
        ],
      ),
    );
  }
}