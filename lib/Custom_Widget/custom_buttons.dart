import 'package:flutter/material.dart';

//? Custom Text Button
class CustomTextButton extends StatelessWidget {
  final Color buttonColor;
  final String label;
  final Function onPressed;
  final double width, height, borderRadius;

  CustomTextButton(
      {this.buttonColor,
      this.label,
      this.onPressed,
      this.height = 30,
      this.width = 50,
      this.borderRadius = 5});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(fontSize: 18, color: (Theme.of(context).canvasColor)),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(15)),
          minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
          backgroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)))),
    );
  }
}
