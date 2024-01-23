import 'package:flutter/material.dart';
import 'package:coffee_application/screen/my_component/graph_shop.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:coffee_application/screen/shop_information.dart';

class ShopBottomNavigationBar extends StatefulWidget {
  const ShopBottomNavigationBar({required this.pageName, Key? key})
      : super(key: key);

  final String pageName;

  @override
  State<ShopBottomNavigationBar> createState() =>
      _ShopBottomNavigationBarState();
}

class _ShopBottomNavigationBarState extends State<ShopBottomNavigationBar> {
  late int _selectedIndex;

  // Define a map to associate page names with their corresponding index
  final Map<String, int> pageNameToIndex = {
    'HOME': 0,
    'PROMOTION': 1,
    'ANALYSIS': 2,
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ShopInformationPage()),
          );
          break;
        case 1:
          // Navigate to Promotion page
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => PromotionScreen()),
          // );
          break;
        case 2:
          // Navigate to Analysis page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ShopGraphPage()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      backgroundColor: brownBorderButton,
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
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]
                  : [],
            ),
          ),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: _selectedIndex == pageNameToIndex['PROMOTION']
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              IconlyLight.discount,
              color: backGroundApplication,
              size: 50,
              shadows: _selectedIndex == pageNameToIndex['PROMOTION']
                  ? [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]
                  : [],
            ),
          ),
          label: 'PROMOTION',
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: _selectedIndex == pageNameToIndex['ANALYSIS']
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              IconlyLight.graph,
              color: backGroundApplication,
              size: 50,
              shadows: _selectedIndex == pageNameToIndex['ANALYSIS']
                  ? [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]
                  : [],
            ),
          ),
          label: 'ANALYSIS',
        ),
      ],
    );
  }
}
