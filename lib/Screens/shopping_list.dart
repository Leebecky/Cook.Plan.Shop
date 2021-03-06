import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("leebecky06@gmail.com")
                .doc("Profile")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                    child: ListTile(title: Text(snapshot.data["Name"]))
                    /*   child: ListView.builder(itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(snapshot.data["Name"]),
                  );
                }) */
                    );
              }

              return CircularProgressIndicator();
            }),
        Spacer(),
        FloatingActionButton(
            child: Icon(Icons.add),
            foregroundColor:
                Theme.of(context).floatingActionButtonTheme.foregroundColor,
            onPressed: () {
              final snackBar = SnackBar(content: Text("Ping!"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            })
      ],
    );
  }
}
