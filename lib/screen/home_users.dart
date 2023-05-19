// import 'dart:ffi';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_application_1/screen/login.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_application_1/screen/register.dart';
// import 'package:flutter_application_1/model/users.dart';
// import 'package:path/path.dart' as Path;
import 'dart:ffi';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/my_component/custompageroute.dart';
import 'package:flutter_application_1/screen/my_component/grid_component.dart';
import 'package:flutter_application_1/screen/search_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'my_component/buttom_navigationbar.dart';
import 'package:flutter_application_1/utility/my_constant.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_application_1/screen/my_component/select_month_week_provider.dart';
import 'package:flutter_application_1/viewmodel/user_home_page.dart';

const mockupHeight = 844;
const mockupWidth = 390;

class home_users extends StatefulWidget {
  const home_users({super.key});

  @override
  State<home_users> createState() => HomeUserState();
}

class HomeUserState extends State<home_users> {
  final UserShopHomePageViewModel viewModel = UserShopHomePageViewModel();

  @override
  void initState() {
    // selectedMonthWeek = viewModel.getSelectedMonthWeek();
    viewModel.frequentlyEat = viewModel.myListThatMightLike;
    viewModel.categoryEatMonth = viewModel.filterProductsByType(
        viewModel.myProductsMonth, viewModel.selectedCategory);
    viewModel.categoryEatWeek = viewModel.filterProductsByType(
        viewModel.myProductsWeek, viewModel.selectedCategory);

    super.initState();
    // print(categoryfood);
    // print(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final scale = mockupWidth / width;

    return PixelPerfect(
      scale: scale,
      assetPath: "assets/images/Homepage.png",
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              searchBar(),
              _sectionBufferHeight(),
              headSliderMenuBar(),
              _sectionBufferHeight(),
              const ItemCategoryHomeUserSlider(),
              _sectionBufferHeight(bufferSection: 30),
              selectableBestOfWeekMonthSection(),
              BuildGridView(
                  selectedList: viewModel.selectedMonthWeek == "month"
                      ? viewModel.categoryEatMonth
                      : viewModel.categoryEatWeek,
                  sectionHeightList: 250),
              _sectionBufferHeight(),
              _sectionBufferHeight(bufferSection: 30),
              _headerFavoriteShop("ร้านประจำ"),
              dividerLine(),
              selectFrequencyFavoriteSection(),
              _headerFavoriteShop("ร้านที่คุณอาจสนใจ"),
              dividerLine(),
              BuildGridView(
                  selectedList: viewModel.myListThatMightLike,
                  sectionHeightList: 250),
              _headerFavoriteShop("ร้านที่มีโปรโมชัน"),
              dividerLine(),
              BuildGridView(
                  selectedList: viewModel.myListShopHasPromotion,
                  sectionHeightList: 250)
            ],
          ),
        ),
        bottomNavigationBar: navigationBar(context),
      ),
    );
  }

  Widget searchBar() {
    return Column(
      children: [
        Center(
          child: ZoomTapAnimation(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                CustomPageRoute(
                  child: UserSearchPage(),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: 345,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.search),
                    // _sectionBufferWidth(bufferSection: 1),
                    AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText("เมนูเส้น"),
                        RotateAnimatedText("เมนูตามสั่ง"),
                        RotateAnimatedText("เมนูของทอด"),
                        RotateAnimatedText("เมนูของหวาน"),
                      ],
                      repeatForever: true,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectFrequencyFavoriteSection() {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // scrollDirection: Axis.horizontal,
            children: [
              _sectionBufferWidth(bufferSection: 10),
              _selectedFavoriteFrequncyMenu("บ่อยสุด"),
              _sectionBufferWidth(bufferSection: 10),
              _selectedFavoriteFrequncyMenu("ล่าสุด"),
              _sectionBufferWidth(bufferSection: 10),
              _selectedFavoriteFrequncyMenu("นานสุด"),
              _sectionBufferWidth(bufferSection: 10),
              _sectionBufferHeight(bufferSection: 10),
            ],
          ),
        ),
        BuildGridView(
            selectedList: viewModel.frequentlyEat, sectionHeightList: 250),
      ],
    );
  }

  Widget _selectedFavoriteFrequncyMenu(String favoriteFrequncyMenu) {
    final isSelected =
        favoriteFrequncyMenu == viewModel.selectedFavoriteFrequncy;

    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? kYellowSelectedButton : kGreyUnSelectedButton,
        ),
        child: Text(
          favoriteFrequncyMenu,
          style: kfontH4Inter(),
        ),
      ),
      onTap: () {
        // favoriteFrequncyMenu = _selectedFavoriteFrequncy;
        viewModel.selectedFavoriteFrequncy = favoriteFrequncyMenu;

        setState(() {
          viewModel.frequentlyEat = viewModel.filterFavoriteItems(
            viewModel.myFavoriteShopUserTwoItems,
            true,
            viewModel.selectedFavoriteFrequncy,
          );
        });
      },
    );
  }

  Widget selectableBestOfWeekMonthSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectableBestOfWeekMonth(
              viral: "ยอดฮิตเดือนนี้",
              isSelected: viewModel.selectedMonthWeek == "month",
              onTap: () {
                setState(() {
                  // print("print");
                  // selectedMonthWeek = "month";
                  viewModel.selectedMonthWeek = "month";
                  viewModel.categoryEatMonth = viewModel.filterProductsByType(
                      viewModel.myProductsMonth, viewModel.selectedCategory);
                });
              },
            ),
            const SizedBox(width: 20),
            _selectableBestOfWeekMonth(
              viral: "ยอดฮิตสัปดาห์นี้",
              isSelected: viewModel.selectedMonthWeek == "week",
              onTap: () {
                // print("Hello");
                setState(() {
                  // viewModel.updateSelectedMonthWeek() = "week";
                  viewModel.selectedMonthWeek = "week";
                  viewModel.categoryEatWeek = viewModel.filterProductsByType(
                      viewModel.myProductsWeek, viewModel.selectedCategory);
                });
              },
            ),
          ],
        ),
        dividerLine(),
        SizedBox(
          height: 30,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            scrollDirection: Axis.horizontal,
            children: [
              _sectionBufferWidth(bufferSection: 10),
              _selectedCategoryMenu("เมนูเส้น"),
              _sectionBufferWidth(bufferSection: 10),
              _selectedCategoryMenu("เมนูตามสั่ง"),
              _sectionBufferWidth(bufferSection: 10),
              _selectedCategoryMenu("เมนูของทอด"),
              _sectionBufferWidth(bufferSection: 10),
              _selectedCategoryMenu("เมนูของหวาน"),
              _sectionBufferWidth(bufferSection: 10),
            ],
          ),
        ),
        _sectionBufferHeight(bufferSection: 10),
      ],
    );
  }

  Widget _selectedCategoryMenu(String categoryMenu) {
    // viewModel.getCategoryType(categoryConvertToEnglish, categoryMenu);
    final isSelected = categoryMenu == viewModel.selectedCategory;

    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? kYellowSelectedButton : kGreyUnSelectedButton,
        ),
        child: Text(
          categoryMenu,
          style: kfontH4Inter(),
        ),
      ),
      onTap: () {
        setState(() {
          print("kuy");
          viewModel.selectedCategory = categoryMenu;
          viewModel.categoryEatMonth = viewModel.filterProductsByType(
              viewModel.myProductsMonth, viewModel.selectedCategory);
          viewModel.categoryEatWeek = viewModel.filterProductsByType(
              viewModel.myProductsWeek, viewModel.selectedCategory);

          // print(categoryfood);
        });
      },
    );
  }

  Widget _selectableBestOfWeekMonth({
    required String viral,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      key: Key(viral),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 165,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? kYellowSelectedButton : kGreyUnSelectedButton,
        ),
        child: Text(
          viral,
          style: kfontH3Inter(),
        ),
      ),
    );
  }
}

Widget _headerFavoriteShop(String favoriteShop) {
  return Container(
    alignment: Alignment.center,
    width: 165,
    height: 25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: kYellowSelectedButton,
    ),
    child: Text(
      favoriteShop,
      style: kfontH3Inter(),
    ),
  );
}

Widget dividerLine() {
  return const Divider(
    thickness: 3,
    indent: 20,
    endIndent: 20,

    // height: ,
    color: Colors.orange,
  );
}

SizedBox _sectionBufferHeight({double bufferSection = 8}) {
  return SizedBox(
    height: bufferSection,
  );
}

SizedBox _sectionBufferWidth({double bufferSection = 8}) {
  return SizedBox(
    width: bufferSection,
  );
}

class ItemCategoryHomeUserSlider extends StatefulWidget {
  const ItemCategoryHomeUserSlider({super.key});

  @override
  State<ItemCategoryHomeUserSlider> createState() =>
      _ItemCategoryHomeUserSliderState();
}

Text headSliderMenuBar() {
  return Text(
    "ร้านค้าแนะนำ",
    style: kfontH1Inter(),
  );
}

class _ItemCategoryHomeUserSliderState
    extends State<ItemCategoryHomeUserSlider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RecommendShopHeader(
          iconImagePath: 'assets/images/dish.png',
          iconText: "กินบ่อย",
        ),
        RecommendShopHeader(
            iconImagePath: 'assets/images/coffee-cup.png', iconText: "กินใกล้")
      ],
    );
  }
}

class RecommendShopHeader extends StatelessWidget {
  final String iconImagePath;
  final String iconText;

  const RecommendShopHeader({
    required this.iconImagePath,
    required String this.iconText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: GestureDetector(
              child: Container(
                // color: Colors.red,
                height: 39,
                width: 39,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(iconImagePath))),
              ),
              onTap: () {
                // TODO: IMPLEMENT THE BUTTON FUNCTION
              },
            ),
          ),
          Text(
            iconText,
            style: kfontH2Inter(),
          )
        ],
      ),
    );
  }
}
