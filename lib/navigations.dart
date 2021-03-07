import 'package:cook_plan_shop/Custom_Widget/custom_alert_dialog.dart';
import 'package:cook_plan_shop/Models/activeUser.dart';
import 'package:cook_plan_shop/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool _isDarkMode;
  List<Widget> _pages = [Planner(), Shelf(), ShoppingList()];

  @override
  void initState() {
    setTheme();
    _currentIndex = 1;
    _isDarkMode = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cook.Plan.Shop"),
        ),
        drawer: sideMenu(context),
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

//^ Sidemenu - Left drawer
  Widget sideMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            trailing: Icon(Icons.info),
            title: Text("About"),
            onTap: () => openDialog(context,
                dialogType: AboutCookShopPlan(
                  contentText: "Logo made by Freepik on www.flaticon.com",
                )),
          ),
          ListTile(
              title: (_isDarkMode) ? Text("Light Mode") : Text("Dark Mode"),
              trailing: (_isDarkMode)
                  ? Icon(Icons.brightness_5)
                  : Icon(Icons.brightness_2),
              onTap: () {
                Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              }),
          Divider(
            thickness: 2,
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.offAll(() => Login());
            },
          ),
        ],
      ),
    );
  }

//? Sets the application theme depending on saved user profile settigns
  void setTheme() async {
    ActiveUser activeUser = await retrieveProfile();
    bool _isDark;

    if (activeUser.preferredTheme == "Dark") {
      _isDark = true;
      Get.changeTheme(ThemeData.dark());
    } else {
      _isDark = false;
      Get.changeTheme(ThemeData.light());
    }
    setState(() {
      _isDarkMode = _isDark;
    });
  }
}
