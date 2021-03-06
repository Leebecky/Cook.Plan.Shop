import 'package:cookbook_planner/Custom_Widget/custom_buttons.dart';
import 'package:flutter/material.dart';

class Shelf extends StatefulWidget {
  @override
  _ShelfState createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      child: Center(
        child: Text("Bookshelf"),
      ),
    );
  }
}
