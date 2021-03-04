import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/navigations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "CookPlan",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        "/": (context) => Navigations(),
      },
    );
  }
}
