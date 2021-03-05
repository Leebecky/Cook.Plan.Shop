import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("Test")
                  .doc("XewPRO4lzTbr44rgy6LI")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  ListView.builder(itemBuilder: (context, i) {
                    return ListTile();
                  });
                }
                return CircularProgressIndicator();
              }),
          FloatingActionButton(onPressed: null)
        ],
      ),
    );
  }
}
