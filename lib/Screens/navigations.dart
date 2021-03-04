import 'package:flutter/material.dart';
import './planner.dart';
import './shopping_list.dart';
import './bookshelf.dart';

class Navigations extends StatefulWidget {
  @override
  _NavigationsState createState() => _NavigationsState();
}

class _NavigationsState extends State<Navigations> {
  int _currentIndex;
  List<Widget> _pages = [Planner(), Shelf(), ShoppingList()];

  @override
  void initState() {
    _currentIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CookPlan"),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: "Meal Planner"),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_stories), label: "Cookbooks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket), label: "Shopping List"),
          ],
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          currentIndex: _currentIndex,
        ));
  }
}
