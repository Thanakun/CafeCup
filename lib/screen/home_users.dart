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
import 'package:flutter_application_1/viewmodel/users_home_viewmodel.dart';

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
    final UserHomePageViewModel viewModel = UserHomePageViewModel();
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
              Search_bar(),
              _sectionBufferHeight(),
              headSliderMenuBar(),
              _sectionBufferHeight(),
              ItemCategoryHomeUserSlider(),
              // StackTest()
              _sectionBufferHeight(bufferSection: 30),
              SelectableBestOfWeekMonthSection(
                viewModel: viewModel,
                onMonthWeekChanged: viewModel.onMonthWeekChanged(),
              ),

              _sectionBufferHeight(),
              _sectionBufferHeight(bufferSection: 30),
              _favoriteShop("ร้านประจำ"),
              dividerLine(),
              SelectFrequencyFavoriteSection()
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
    required this.onMonthWeekChanged,
    Key? key,
  }) : super(key: key);

  final UserHomePageViewModel viewModel;
  final List onMonthWeekChanged;

  @override
  State<SelectableBestOfWeekMonthSection> createState() =>
      SelectableBestOfWeekMonthSectionState();
}

class SelectableBestOfWeekMonthSectionState
    extends State<SelectableBestOfWeekMonthSection> {
  String selectedMonthWeek = "month";
  String selectedCategory = "เมนูเส้น";
  late List categoryEatMonth;
  late List categoryEatWeek;
  // late List interestingEat;

  @override
  void initState() {
    selectedMonthWeek = widget.viewModel.getSelectedMonthWeek();
    categoryEatMonth = widget.viewModel.myProductsMonth
        .where(
          (item) => item['type'] == selectedCategory,
        )
        .toList();
    categoryEatWeek = widget.viewModel.myProductsWeek
        .where(
          (item) => item['type'] == selectedCategory,
        )
        .toList();
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
              isSelected: selectedMonthWeek == "month",
              onTap: () {
                setState(() {
                  selectedMonthWeek = "month";
                  widget.viewModel.updateSelectedMonthWeek("month");
                });
              },
            ),
            const SizedBox(width: 20),
            _selectableBestOfWeekMonth(
              viral: "ยอดฮิตสัปดาห์นี้",
              isSelected: selectedMonthWeek == "week",
              onTap: () {
                setState(() {
                  selectedMonthWeek = "week";
                  widget.viewModel.updateSelectedMonthWeek("week");
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
              itemCount: selectedMonthWeek == "month"
                  ? categoryEatMonth.length
                  : categoryEatWeek.length,
              itemBuilder: (context, index) {
                int item = selectedMonthWeek == "month"
                    ? categoryEatMonth.length
                    : categoryEatWeek.length;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Column(
                    children: [
                      Text(
                        selectedMonthWeek == "month"
                            ? categoryEatMonth[index]["name"]
                            : categoryEatWeek[index]["name"],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        selectedMonthWeek == "month"
                            ? categoryEatMonth[index]["type"]
                            : categoryEatWeek[index]["type"],
                        style: kfontH3Inter(),
                      ),
                    ],
                  ),
                  // child: Column(
                  //   children: [
                  //     Text(
                  //       item['name'].toString(),
                  //       style: TextStyle(color: Colors.white, fontSize: 20),
                  //     ),
                  //     Text(
                  //       widget.viewModel.getCategoryType(
                  //           item["name"].toString(), selectedCategory),
                  //       style: kfontH3Inter(),
                  //     ),
                  //   ],
                  // ),
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
    final isSelected = categoryMenu == selectedCategory;

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
          selectedCategory = categoryMenu;
          categoryEatMonth = widget.viewModel.myProductsMonth
              .where(
                (item) => item['type'] == selectedCategory,
              )
              .toList();
          categoryEatWeek = widget.viewModel.myProductsWeek
              .where(
                (item) => item['type'] == selectedCategory,
              )
              .toList();
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
  const SelectFrequencyFavoriteSection({super.key});

  @override
  State<SelectFrequencyFavoriteSection> createState() =>
      _SelectFrequencyFavoriteSectionState();
}

class _SelectFrequencyFavoriteSectionState
    extends State<SelectFrequencyFavoriteSection> {
  String _selectedFavoriteFrequncy = "บ่อยสุด";
  late List frequentlyEat;

  @override
  void initState() {
    // frequentlyEat = widget.viewModel.myProductsMonth
    //     .where(
    //       (item) => item['type'] == selectedCategory,
    //     )
    //     .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                itemCount: frequentlyEat.length,
                itemBuilder: (context, index) {
                  int item = frequentlyEat.length;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Column(
                      children: [
                        Text(
                          frequentlyEat[index]["name"],
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          frequentlyEat[index]["type"],
                          style: kfontH3Inter(),
                        ),
                      ],
                    ),
                    // child: Column(
                    //   children: [
                    //     Text(
                    //       item['name'].toString(),
                    //       style: TextStyle(color: Colors.white, fontSize: 20),
                    //     ),
                    //     Text(
                    //       widget.viewModel.getCategoryType(
                    //           item["name"].toString(), selectedCategory),
                    //       style: kfontH3Inter(),
                    //     ),
                    //   ],
                    // ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectedFavoriteFrequncyMenu(String favoriteFrequncyMenu) {
    final isSelected = favoriteFrequncyMenu == _selectedFavoriteFrequncy;

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
        setState(() {
          print(_selectedFavoriteFrequncy);
          _selectedFavoriteFrequncy = favoriteFrequncyMenu;
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

class Search_bar extends StatelessWidget {
  const Search_bar({super.key});

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
                  // boxShadow: [BoxShadow(color: Colors.black)],
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.white70,
                ),
                child: TextFormField(
                  // textAlign: TextAlign.center,

                  decoration: InputDecoration(
                      // TODO : IMPLEMENT MICROPHONE
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: IconButton(
                          padding: EdgeInsets.all(2),
                          key: Key("microphone"),
                          onPressed: () {
                            print("Clicking mic icon");
                          },
                          icon: Icon(Icons.mic)),
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: 'Search for . . . ',
                      hintStyle: TextStyle(color: Colors.grey.shade400)),
                )),
            onPressed: () {
              print("click search bar container");
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
