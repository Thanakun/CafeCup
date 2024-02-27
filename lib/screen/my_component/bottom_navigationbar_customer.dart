import 'package:coffee_application/model/login.dart';
import 'package:coffee_application/screen/customer_home_view.dart';
import 'package:coffee_application/screen/customer_promotion.dart';
import 'package:coffee_application/screen/customer_review_view.dart';
import 'package:coffee_application/screen/logout.dart';
import 'package:coffee_application/screen/promotion.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/screen/my_component/graph_shop.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:coffee_application/screen/shop_information.dart';

class CustomerNavigationBar extends StatefulWidget {
  const CustomerNavigationBar({required this.pageName, Key? key})
      : super(key: key);

  final String pageName;

  @override
  State<CustomerNavigationBar> createState() => _CustomerNavigationBarState();
}

class _CustomerNavigationBarState extends State<CustomerNavigationBar> {
  late int _selectedIndex;

  // Define a map to associate page names with their corresponding index
  final Map<String, int> pageNameToIndex = {
    'HOME': 0,
    'REVIEW': 1,
    'PROMOTION': 2,
    'LOGOUT': 3
  };

  @override
  void initState() {
    // Set the initial value of _selectedIndex based on the widget's pageName
    _selectedIndex = pageNameToIndex[widget.pageName] ?? 0;
    super.initState();
  }

  void _onItemTap(int index) {
    // Check if the widget is still mounted before calling setState
    if (mounted) {
      // Use the index from the map based on the pageName
      switch (index) {
        case 0:
          // Navigate to Home page
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const CustomerHomePageView()),
              (Route<dynamic> route) => false);
          break;
        case 1:

          //TODO REVIEW PAGE
          // Navigate to Promotion page
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CustomerReviewPage()),
              (Route<dynamic> route) => false);

          break;
        case 2:

          //TODO CODE PAGE
          // Navigate to Analysis page
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const CustomerPromotionView()),
              (Route<dynamic> route) => false);

          break;

        //TODO LOGOUT PAGE
        case 3:
          // Navigate to Analysis page
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LogOutPage()),
              (Route<dynamic> route) => false);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      backgroundColor: colorBackGroundNavBar,
      selectedFontSize: 20,
      selectedLabelStyle: kfontH1InterWhiteColor(),
      unselectedFontSize: 16,
      selectedItemColor: Colors.white,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          _onItemTap(index);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: _selectedIndex == pageNameToIndex['HOME']
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              IconlyLight.home,
              color: backGroundApplication,
              size: 50,
              shadows: _selectedIndex == pageNameToIndex['HOME']
                  ? [
                      const BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]
                  : [],
            ),
          ),
          label: 'NAVIGATIONBAR.HOME_NAVIGATION'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: _selectedIndex == pageNameToIndex['REVIEW']
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.rate_review_outlined,
              color: backGroundApplication,
              size: 50,
              shadows: _selectedIndex == pageNameToIndex['REVIEW']
                  ? [
                      const BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]
                  : [],
            ),
          ),
          label: 'NAVIGATIONBAR.REVIEW_NAVIGATION'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: _selectedIndex == pageNameToIndex['CODE']
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.discount_outlined,
              color: backGroundApplication,
              size: 50,
              shadows: _selectedIndex == pageNameToIndex['CODE']
                  ? [
                      const BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]
                  : [],
            ),
          ),
          label: 'NAVIGATIONBAR.CODE_NAVIGATION'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: _selectedIndex == pageNameToIndex['LOGOUT']
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              IconlyLight.logout,
              color: backGroundApplication,
              size: 50,
              shadows: _selectedIndex == pageNameToIndex['LOGOUT']
                  ? [
                      const BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]
                  : [],
            ),
          ),
          label: 'NAVIGATIONBAR.LOGOUT_NAVIGATION'.tr(),
        ),
      ],
    );
  }
}
