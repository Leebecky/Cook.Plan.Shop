import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShoppingList {
  // Map shoppingListItem;

  ShoppingList(List<ShoppingListItem> shoppingListItem);
}

class ShoppingListItem {
  String notes, unit;
  String amount;
  bool isChecked, isWeekly;

  ShoppingListItem(
      this.amount, this.notes, this.unit, this.isChecked, this.isWeekly);
}

//? Converts key/value pairs from database to ShoppingListItem object
List<Map<String, ShoppingListItem>> shoppingListItemFromDb(
    Map<dynamic, dynamic> dbData) {
  Map<String, ShoppingListItem> myItems;
  List<Map<String, ShoppingListItem>> shoppingList = [];
  dbData.forEach((key, value) {
    myItems = {
      key: ShoppingListItem(
        value["Amount"] as String,
        value["Notes"] as String,
        value["Unit"] as String,
        value["isChecked"] as bool,
        value["isWeekly"] as bool,
      )
    };
    shoppingList.add(myItems);
  });
  return shoppingList;
}

//? Converts the ShoppingListItem object into key/value pairs
Map<dynamic, dynamic> shoppingListItemToMap(ShoppingListItem instance) =>
    <dynamic, dynamic>{
      "Amount": instance.amount,
      "Notes": instance.notes,
      "Unit": instance.unit,
      "isChecked": instance.isChecked,
      "isWeekly": instance.isWeekly,
    };

//? Retrieve Shopping List from database
Future<List<Map<String, ShoppingListItem>>> getShoppingList() async {
  String email = FirebaseAuth.instance.currentUser.email;

  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection(email)
      .doc("ShoppingList")
      .get();

  List<Map<String, ShoppingListItem>> myShoppingList =
      shoppingListItemFromDb(snapshot.data());

  //Sorts the shopping list items alphabetically
  myShoppingList.sort((a, b) {
    var keyA = a.keys;
    var keyB = b.keys;
    return keyA.toString().compareTo(keyB.toString());
  });
  return myShoppingList;
}
