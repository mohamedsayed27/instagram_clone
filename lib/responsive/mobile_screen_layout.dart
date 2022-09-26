import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int pageNumber = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTaped(int page){
    pageController.jumpToPage(page);
  }
  
  void onPageChanged(int page){
    setState(() {
      pageNumber = page;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar:
          CupertinoTabBar(
              backgroundColor: mobileBackgroundColor,
              items: [
                BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: pageNumber == 0 ? primaryColor : secondaryColor,
            ),
            backgroundColor: primaryColor,
            label: ''),
                BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: pageNumber == 1 ? primaryColor : secondaryColor),
            backgroundColor: primaryColor,
            label: ''),
                BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
                color: pageNumber == 2 ? primaryColor : secondaryColor),
            backgroundColor: primaryColor,
            label: ''),
                BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outlined,
                color: pageNumber == 3 ? primaryColor : secondaryColor),
            backgroundColor: primaryColor,
            label: ''),
                BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: pageNumber == 4 ? primaryColor : secondaryColor),
            backgroundColor: primaryColor,
            label: ''),
              ],
              onTap: navigationTaped,
          ),
    );
  }
}
