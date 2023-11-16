import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/my_component/buttom_navigationbar_user.dart';
import 'package:flutter_application_1/screen/my_component/search_view_component/shop_close_card.dart';
import 'package:flutter_application_1/screen/shop_page.dart';
import 'package:flutter_application_1/viewmodel/search_view_page.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:flutter_application_1/utility/my_constant.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_application_1/screen/my_component/search_view_component/shop_open_card.dart';
import 'package:flutter/rendering.dart';

const mockupHeight = 844;
const mockupWidth = 390;

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({super.key});

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  //For bussinessLogic
  TextEditingController searchText = TextEditingController();
  final SearchViewModel _searchViewModel = SearchViewModel();

  // For decoration

  bool isDropDownClicked = false;
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await _searchViewModel.fetchAllShopItem();
    await _searchViewModel.fetchAllReviewRecordItem();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final scale = mockupWidth / width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            ZoomTapAnimation(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  size: 35,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            searchBar(),
            filterAndOrderSection(),
            _buildShopList(
                cardHeight: height * 0.15, cardWidth: width * 0.2564),
          ],
        ),
        bottomNavigationBar: userBottomNavigationBar(context),
      ),
    );
  }

  Container filterAndOrderSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          shopOpenSelection(),
          sectionBufferWidth(bufferSection: 10),
          orderItemByScore()
        ],
      ),
    );
  }

  Expanded orderItemByScore() {
    return Expanded(
      flex: 5,

      //TODO  to be implement the filter order by . . .
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: const Row(
            children: [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.orange,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: _searchViewModel.itemsFilterOrder
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: kfontH2InterWhiteColor(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: _searchViewModel.searchFilterOrder,
          onChanged: (value) {
            setState(() {
              _searchViewModel.searchFilterOrder = value as String;
              _searchViewModel.onUserSearchItemFilter(searchText.text);
              // _searchViewModel.listAllFilterShop = ;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 35,
            width: 270,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: kRedButton),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 16,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.yellow,
          ),
          dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 270,
              // padding: null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: kRedButton,
              ),
              elevation: 8,
              // offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(8),
                // thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              )),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }

  Expanded shopOpenSelection() {
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () {
          setState(() {
            _searchViewModel.isCheckedTheFilterTime =
                !_searchViewModel.isCheckedTheFilterTime;
            _searchViewModel.onUserSearchItemFilter(searchText.text);
            // print);
          });
        },
        child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 4),
            width: 100,
            height: 30,
            decoration: BoxDecoration(
                color: kPinkInactiveColor,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "เปิดอยู่",
                    style: kfontH2InterBlackColor(),
                  ),
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                  // margin: EdgeInsets.all(0),
                  child: Checkbox(
                    shape: const CircleBorder(),
                    value: _searchViewModel.isCheckedTheFilterTime,
                    onChanged: (bool? value) {
                      setState(() {
                        _searchViewModel.isCheckedTheFilterTime = value!;
                        _searchViewModel
                            .onUserSearchItemFilter(searchText.text);
                        // print(_searchViewModel
                        //     .isCheckedTheFilterTime);
                      });
                    },
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 345,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        width: 100,
        height: 100,
        child: TextFormField(
          style: kfontH2InterBlackColor(),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              key: const Key(
                "microphone",
              ),
              onPressed: () {
                // print("Clicking mic icon");
              },
              icon: const Icon(
                Icons.mic,
                size: 30,
              ),
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 40,
            ),
            border: InputBorder.none,
            hintText: 'Search for...',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),
          onChanged: (value) {
            setState(
              () {
                searchText.text = value;
                _searchViewModel.onUserSearchItemFilter(searchText.text);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildShopList(
      {required double cardHeight, required double cardWidth}) {
    if (_searchViewModel.listAllFilterShop == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (_searchViewModel.listAllFilterShop!.isEmpty) {
      return const Center(child: Text('No shops found.'));
    } else {
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _searchViewModel.listAllFilterShop!.length,
          itemBuilder: (context, index) {
            return Container(
              // curve: Curves.easeInOut,
              // duration: Duration(milliseconds: 500 + (index * 100)),
              // transform: Matrix4.translationValues(
              //     startAnimation ? 0 : MediaQuery.of(context).size.width,
              //     0,
              //     0),
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: _searchViewModel.listAllFilterShop![index].shopOpenTime
                          .isBefore(_searchViewModel.isOpenCurrentTime) &&
                      _searchViewModel.listAllFilterShop![index].shopCloseTime
                          .isAfter(_searchViewModel.isOpenCurrentTime)
                  ? ShopOpenCard(
                      cardHeight: cardHeight,
                      cardWidth: cardWidth,
                      index: index,
                      getShopAllFilterName:
                          _searchViewModel.listAllFilterShop![index].shopName,
                      getShopOpenTime: _searchViewModel
                          .listAllFilterShop![index].shopOpenTime,
                      getShopCloseTime: _searchViewModel
                          .listAllFilterShop![index].shopCloseTime,
                      allAverageScore: _searchViewModel
                          .listAllFilterShop![index].shopAverageAllScore,
                      totalReview: _searchViewModel.listShopReviewRecord
                              ?.where((review) =>
                                  review.shopId ==
                                  _searchViewModel
                                      .listAllFilterShop![index].shopId)
                              .length ??
                          0,
                      navigateToShop: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopPage(
                                    // shop: _searchViewModel.getShopById(
                                    //     _searchViewModel
                                    //         .listAllFilterShop![index]
                                    //         .shopId)
                                    shop: _searchViewModel
                                        .listAllFilterShop![index])));
                        // print(
                        //     _searchViewModel.listAllFilterShop![index].shopId);
                      },
                    )
                  : ShopCloseCard(
                      cardHeight: cardHeight,
                      cardWidth: cardWidth,
                      index: index,
                      getShopAllFilterName:
                          _searchViewModel.listAllFilterShop![index].shopName,
                      allAverageScore: _searchViewModel
                          .listAllFilterShop![index].shopAverageAllScore,
                      getShopOpenTime: _searchViewModel
                          .listAllFilterShop![index].shopOpenTime,
                      getShopCloseTime: _searchViewModel
                          .listAllFilterShop![index].shopCloseTime,
                      totalReview: _searchViewModel.listShopReviewRecord
                              ?.where((review) =>
                                  review.shopId ==
                                  _searchViewModel
                                      .listAllFilterShop![index].shopId)
                              .length ??
                          0),
            );
          },
        ),
      );
    }
  }
}
