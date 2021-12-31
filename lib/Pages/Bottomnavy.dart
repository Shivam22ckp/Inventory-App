import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Pages/Home.dart';
import 'package:inventory/Pages/Orders.dart';
import 'package:inventory/Pages/Profilepage.dart';
import 'package:inventory/Pages/upload.dart';

class BottomNavy extends StatefulWidget {
  BottomNavy({Key? key}) : super(key: key);

  @override
  _BottomNavyState createState() => _BottomNavyState();
}

class _BottomNavyState extends State<BottomNavy> {
  int currentTabIndex = 0;
  late List<Widget> pages;

  late Widget currentPage;

  late Home home;

  late Upload uploadpage;
  late Orders orders;
  late ProfilePage profile;

  @override
  void initState() {
    super.initState();

    home = Home();

    uploadpage = Upload();
    orders = Orders();
    profile = ProfilePage();

    pages = [home, uploadpage, orders, profile];
    currentPage = home;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        animationDuration: Duration(microseconds: 1000),
        selectedIndex: currentTabIndex,
        onItemSelected: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            activeColor: Colors.green,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.upload),
            title: Text("Upload"),
            activeColor: Color.fromRGBO(255, 138, 120, 1),
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Orders"),
            activeColor: Colors.redAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            activeColor: Colors.blue,
            inactiveColor: Colors.black,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
