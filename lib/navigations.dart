import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/planner.dart';
import 'Screens/shopping_list.dart';
import 'Screens/bookshelf.dart';

class Navigations extends StatefulWidget {
  @override
  _NavigationsState createState() => _NavigationsState();
}

//^ Bottom Navigation Bar
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
        drawer: sideMenu(),
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

//^ Sidemenu - Left drawer
Widget sideMenu() {
  return Drawer(
    child: ListView(
      children: [
        ListTile(
            title: (Get.isDarkMode) ? Text("Light Mode") : Text("Dark Mode"),
            trailing: (Get.isDarkMode)
                ? Icon(Icons.brightness_5)
                : Icon(Icons.brightness_2),
            onTap: () => Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
                ))
      ],
    ),
  );
}
