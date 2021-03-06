import 'package:flutter/material.dart';
import 'package:get/get.dart';

//? Method to open the Alert Dialog (Can be customised later to open other dialogs)
void openDialog(BuildContext context, {String titleText, String contentText}) {
  showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
            titleText: titleText,
            contentText: contentText,
          ));
}

//? Custom Alert Dialog - Has a title, content and close button
class CustomAlertDialog extends StatelessWidget {
  final String titleText, contentText;

  CustomAlertDialog({this.titleText, this.contentText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: [TextButton(onPressed: () => Get.back(), child: Text("Close"))],
    );
  }
}
