import 'package:cookbook_planner/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
          //! Return Error screen
          if (snapshot.hasError) {
            return Text("Please wait!");
          }

          //~ Once intialised, return app
          if (snapshot.connectionState == ConnectionState.done) {
            Widget homeRoute = checkLoggedIn();
            return MyApp(homeRoute);
          }

          return SpinKitPouringHourglass(color: Colors.blue[200]);
        });
  }
}

class MyApp extends StatelessWidget {
  final Widget homeRoute;
  MyApp(this.homeRoute);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Cook.Plan.Shop",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: homeRoute,
      /*  routes: {
        "/": (context) => checkLoggedIn(),
      }, */
    );
  }
}

//? Checks if the user is logged in and returns the appropriate route
Widget checkLoggedIn() {
  User user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Login();
  } else {
    return Navigations();
  }
}
