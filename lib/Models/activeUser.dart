import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Model class for retrieving ActiveUser data
class ActiveUser {
  //^ Attributes
  String name, preferredTheme, unitType;

  //^ Constructor
  ActiveUser(this.name, this.preferredTheme, this.unitType);

  //^ Factory - Implementing a constructor doesn't always create a new ActiveUser instance.
  factory ActiveUser.fromDb(Map<dynamic, dynamic> dbData) =>
      _activeUserFromDb(dbData);

  Map<dynamic, dynamic> toMap() => _activeUserToMap(this);
}

//? Converts map of values from Firestore into ActiveUser class.
//! This method is invoked by ActiveUser.fromDb. Don't call this method.
ActiveUser _activeUserFromDb(Map<dynamic, dynamic> dbData) {
  return ActiveUser(
    dbData["Name"] as String,
    dbData["Theme"] as String,
    dbData["UnitType"] as String,
  );
}

//? Converts the ActiveUser object into key/value pairs
Map<String, String> _activeUserToMap(ActiveUser instance) => <String, String>{
      "Name": instance.name,
      "Theme": instance.preferredTheme,
      "UnitType": instance.unitType,
    };

//? Retrieves ActiveUser profile
Future<ActiveUser> retrieveProfile() async {
  ActiveUser activeUser;
  String email = FirebaseAuth.instance.currentUser.email;
  await FirebaseFirestore.instance
      .collection(email)
      .doc("Profile")
      .get()
      .then((snapshot) => activeUser = ActiveUser.fromDb(snapshot.data()));

  return activeUser;
}
