import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Color borderColor;

  CustomTextField({this.controller, this.labelText, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (borderColor == null)
                      ? Theme.of(context).accentColor
                      : borderColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (borderColor == null)
                      ? Theme.of(context).accentColor
                      : borderColor))),
    );
  }
}
