import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/home_users.dart';
import 'package:flutter_application_1/screen/search_page.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:flutter_application_1/utility/my_constant.dart';

BottomAppBar userBottomNavigationBar(BuildContext context) {
  return BottomAppBar(
    height: 88,
    notchMargin: 30,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bottomAppBarItem(context,
              icon: IconlyLight.home, page: 0, label: "Home", onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeUsers()));
          }),
          _bottomAppBarItem(context,
              icon: Icons.history, page: 1, label: "History", onTap: null),
          _bottomAppBarItem(context,
              icon: IconlyLight.search, page: 2, label: "Search", onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => UserSearchPage()));
          }),
          _bottomAppBarItem(context,
              icon: Icons.reviews, page: 3, label: "Review", onTap: null),
          _bottomAppBarItem(context,
              icon: Icons.more_horiz, page: 4, label: "Others", onTap: null),
        ],
      ),
    ),
  );
}

Widget _bottomAppBarItem(BuildContext context,
    {required icon, required page, required label, required onTap}) {
  return ZoomTapAnimation(
    key: Key(label),
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 32,
          ),
          Text(
            label,
            style: kfontH3InterBlackColor(),
          )
        ],
      ),
    ),
  );
}
