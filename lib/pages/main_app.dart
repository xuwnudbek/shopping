import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopping/consts.dart';
import 'package:shopping/pages/backet_page.dart';
import 'package:shopping/pages/home_page.dart';
import 'package:shopping/pages/profile_page.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  PageController _pageController = PageController(
    initialPage: 0,
  );
  int currentPageIndex = 0;
  List pages = [
    HomePage(),
    BacketPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(
      initialPage: currentPageIndex,
    );
    // FocusScope.of(context).unfocus();

    return Scaffold(
      body: SafeArea(child: pages[currentPageIndex]),
      bottomNavigationBar: AnimatedNotchBottomBar(
        pageController: _pageController,
        bottomBarItems: [
          BottomBarItem(
            activeItem: Icon(Ionicons.home, color: primaryColor),
            inActiveItem: Icon(Ionicons.home_outline),
            itemLabel: "Home",
          ),
          BottomBarItem(
            activeItem: Icon(Ionicons.bag_handle_sharp, color: primaryColor),
            inActiveItem: Icon(Ionicons.bag_handle_outline),
            itemLabel: "Backet",
          ),
          BottomBarItem(
            activeItem: Icon(Ionicons.person_sharp, color: primaryColor),
            inActiveItem: Icon(Ionicons.person_outline),
            itemLabel: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
