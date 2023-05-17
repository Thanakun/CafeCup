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

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'my_component/buttom_navigationbar.dart';
import 'package:flutter_application_1/utility/my_constant.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/my_component/select_month_week_provider.dart';
import 'package:flutter_application_1/viewmodel/user_home_page.dart';

const mockupHeight = 844;
const mockupWidth = 390;

class home_users extends StatefulWidget {
  const home_users({super.key});

  @override
  State<home_users> createState() => HomeUserState();
}

class HomeUserState extends State<home_users> {
  @override
  Widget build(BuildContext context) {
    // String _selectedOption = "month";
    final UserShopHomePageViewModel viewModel = UserShopHomePageViewModel();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final scale = mockupWidth / width;
    // final

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
          child: Column(
            children: [
              SearchBar(),
              _sectionBufferHeight(),
              headSliderMenuBar(),
              _sectionBufferHeight(),
              ItemCategoryHomeUserSlider(),
              // StackTest()
              _sectionBufferHeight(bufferSection: 30),
              SelectableBestOfWeekMonthSection(
                viewModel: viewModel,
                // onMonthWeekChanged: viewModel.onMonthWeekChanged(),
              ),

              _sectionBufferHeight(),
              _sectionBufferHeight(bufferSection: 30),
              _favoriteShop("ร้านประจำ"),
              dividerLine(),
              SelectFrequencyFavoriteSection(
                viewModel: viewModel,
              )
            ],
          ),
        ),
        bottomNavigationBar: navigationBar(context),
      ),
    );
  }
}

class SelectableBestOfWeekMonthSection extends StatefulWidget {
  const SelectableBestOfWeekMonthSection({
    required this.viewModel,
    // required this.onMonthWeekChanged,
    Key? key,
  }) : super(key: key);

  final UserShopHomePageViewModel viewModel;
  // final List onMonthWeekChanged;

  @override
  State<SelectableBestOfWeekMonthSection> createState() =>
      SelectableBestOfWeekMonthSectionState();
}

class SelectableBestOfWeekMonthSectionState
    extends State<SelectableBestOfWeekMonthSection> {
  // String selectedMonthWeek = "month";
  // late String selectedCategory = "เมนูเส้น";
  // late List categoryEatMonth;
  // late List categoryEatWeek;
  // late List interestingEat;

  @override
  void initState() {
    // selectedMonthWeek = widget.viewModel.getSelectedMonthWeek();
    widget.viewModel.categoryEatMonth = widget.viewModel.filterProductsByType(
        widget.viewModel.myProductsMonth, widget.viewModel.selectedCategory);
    widget.viewModel.categoryEatWeek = widget.viewModel.filterProductsByType(
        widget.viewModel.myProductsWeek, widget.viewModel.selectedCategory);

    super.initState();
    // print(categoryfood);
    // print(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectableBestOfWeekMonth(
              viral: "ยอดฮิตเดือนนี้",
              isSelected: widget.viewModel.selectedMonthWeek == "month",
              onTap: () {
                setState(() {
                  print("print");
                  // selectedMonthWeek = "month";
                  widget.viewModel.selectedMonthWeek = "month";
                  widget.viewModel.categoryEatMonth = widget.viewModel.filterProductsByType(
                      widget.viewModel.myProductsMonth, widget.viewModel.selectedCategory);
                });
              },
            ),
            const SizedBox(width: 20),
            _selectableBestOfWeekMonth(
              viral: "ยอดฮิตสัปดาห์นี้",
              isSelected: widget.viewModel.selectedMonthWeek == "week",
              onTap: () {
                print("Hello");
                setState(() {
                  // widget.viewModel.updateSelectedMonthWeek() = "week";
                  widget.viewModel.selectedMonthWeek = "week";
                  widget.viewModel.categoryEatWeek = widget.viewModel.filterProductsByType(
                      widget.viewModel.myProductsWeek, widget.viewModel.selectedCategory);
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
        SizedBox(
          height: 400,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 21, vertical: 13),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 221,
                childAspectRatio: 160 / 123,
                crossAxisSpacing: 21,
                mainAxisSpacing: 13,
              ),
              itemCount: widget.viewModel.selectedMonthWeek == "month"
                  ? widget.viewModel.categoryEatMonth.length
                  : widget.viewModel.categoryEatWeek.length,
              itemBuilder: (context, index) {
                List selectedList = widget.viewModel.selectedMonthWeek == "month"
                    ? widget.viewModel.categoryEatMonth
                    : widget.viewModel.categoryEatWeek;
                // print(widget.viewModel.getItemCount());
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Column(
                    children: [
                      Text(
                        selectedList[index]["name"],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        selectedList[index]["type"],
                        style: kfontH3Inter(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectedCategoryMenu(String categoryMenu) {
    // widget.viewModel.getCategoryType(categoryConvertToEnglish, categoryMenu);
    final isSelected = categoryMenu == widget.viewModel.selectedCategory;

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
          widget.viewModel.selectedCategory = categoryMenu;
          widget.viewModel.categoryEatMonth = widget.viewModel.filterProductsByType(
              widget.viewModel.myProductsMonth, widget.viewModel.selectedCategory);
          widget.viewModel.categoryEatWeek = widget.viewModel.filterProductsByType(
              widget.viewModel.myProductsWeek, widget.viewModel.selectedCategory);

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

class SelectFrequencyFavoriteSection extends StatefulWidget {
  const SelectFrequencyFavoriteSection({Key? key, required this.viewModel})
      : super(key: key);
  final UserShopHomePageViewModel viewModel;

  @override
  State<SelectFrequencyFavoriteSection> createState() =>
      _SelectFrequencyFavoriteSectionState();
}

class _SelectFrequencyFavoriteSectionState
    extends State<SelectFrequencyFavoriteSection> {
  // String _selectedFavoriteFrequncy = "บ่อยสุด";
  // late List frequentlyEat;

  @override
  void initState() {
    widget.viewModel.frequentlyEat = widget.viewModel.filterFavoriteItems(
      widget.viewModel.myFavoriteShopUserTwoItems,
      true,
      widget.viewModel.selectedFavoriteFrequncy,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        SizedBox(
          height: 400,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 21, vertical: 13),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 221,
                childAspectRatio: 160 / 123,
                crossAxisSpacing: 21,
                mainAxisSpacing: 13,
              ),
              itemCount: widget.viewModel.frequentlyEat.length,
              itemBuilder: (context, index) {
                int item = widget.viewModel.frequentlyEat.length;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.viewModel.frequentlyEat[index]["name"],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        widget.viewModel.frequentlyEat[index]["type"],
                        style: kfontH3Inter(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectedFavoriteFrequncyMenu(String favoriteFrequncyMenu) {
    final isSelected = favoriteFrequncyMenu == widget.viewModel.selectedFavoriteFrequncy;

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
        widget.viewModel.selectedFavoriteFrequncy = favoriteFrequncyMenu;

        setState(() {
          widget.viewModel.frequentlyEat = widget.viewModel.filterFavoriteItems(
            widget.viewModel.myFavoriteShopUserTwoItems,
            true,
            widget.viewModel.selectedFavoriteFrequncy,
          );
        });
      },
    );
  }
}

Widget _favoriteShop(String favoriteShop) {
  return GestureDetector(
    key: Key(favoriteShop),
    onTap: () {
      // setState(() {
      //   print(viral);
      //   _selectedOption = viral == "ยอดฮิตเดือนนี้" ? "month" : "week";
      // });
    },
    child: Container(
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

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: TextButton(
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
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.all(2),
                    key: Key("microphone"),
                    onPressed: () {
                      // print("Clicking mic icon");
                    },
                    icon: Icon(Icons.mic),
                  ),
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search for...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                ),
              ),
            ),
            onPressed: () {
              // print("Clicking search bar container");
            },
          ),
        ),
      ],
    );
  }
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
