import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navigations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Initializer());
}

class Initializer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          //? Checks if Firebase has been initialised:
          //~ If error
          //TODO Error screen
          if (snapshot.hasError) {
            return Text("Please wait!");
          }

          //~ Once intialised, return app
          if (snapshot.connectionState == ConnectionState.done) {
            return MyApp();
          }

          //~ Else, return Loading screen
          //TODO SplashScreen/Loading screen
          return CircularProgressIndicator();
        });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "CookPlan",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        "/": (context) => Navigations(),
      },
    );
  }
}
