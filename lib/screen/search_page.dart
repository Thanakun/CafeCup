import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/my_component/buttom_navigationbar_user.dart';
import 'package:flutter_application_1/viewmodel/search_view_page.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:flutter_application_1/utility/my_constant.dart';
import 'package:intl/intl.dart';

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

  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    initializeData();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(
          () {
            startAnimation = true;
          },
        );
      },
    );
  }

  Future<void> initializeData() async {
    await _searchViewModel.fetchAllShopItem();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final scale = mockupWidth / width;

    return PixelPerfect(
      scale: scale,
      assetPath: "assets/images/Searchpage.png",
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                        key: Key(
                          "microphone",
                        ),
                        onPressed: () {
                          // print("Clicking mic icon");
                        },
                        icon: Icon(
                          Icons.mic,
                          size: 30,
                        ),
                      ),
                      prefixIcon: Icon(
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
                          _searchViewModel
                              .onUserSearchItemFilter(searchText.text);
                        },
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _searchViewModel.isCheckedTheFilterTime =
                                !_searchViewModel.isCheckedTheFilterTime;
                            _searchViewModel
                                .onUserSearchItemFilter(searchText.text);
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
                                  padding: EdgeInsets.symmetric(horizontal: 5),
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
                                    shape: CircleBorder(),
                                    value:
                                        _searchViewModel.isCheckedTheFilterTime,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _searchViewModel
                                            .isCheckedTheFilterTime = value!;
                                        _searchViewModel.onUserSearchItemFilter(
                                            searchText.text);
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
                    ),
                    _sectionBufferWidth(bufferSection: 10),
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              color: kRedButton,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Filter",
                            style: kfontH1InterWhiteColor(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildShopList(
                  cardHight: height * 0.15, cardWidth: width * 0.2564),
            ],
          ),
          bottomNavigationBar: userBottomNavigationBar(context),
        ),
      ),
    );
  }

  Widget _buildShopList(
      {required double cardHight, required double cardWidth}) {
    if (_searchViewModel.listFilterShopFuture == null) {
      return Center(child: CircularProgressIndicator());
    } else if (_searchViewModel.listFilterShopFuture!.isEmpty) {
      return Center(child: Text('No shops found.'));
    } else {
      return Expanded(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _searchViewModel.listFilterShopFuture!.length,
          itemBuilder: (context, index) {
            return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 500 + (index * 100)),
              transform: Matrix4.translationValues(
                  startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
              margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: _searchViewModel.listFilterShopFuture![index].shopOpenTime
                          .isBefore(_searchViewModel.isOpenCurrentTime) &&
                      _searchViewModel
                          .listFilterShopFuture![index].shopCloseTime
                          .isAfter(_searchViewModel.isOpenCurrentTime)
                  ? shopOpenListCard(cardHight, cardWidth, index)
                  : shopCloseListCard(cardHight, cardWidth, index),
            );
          },
        ),
      );
    }
  }

  Container shopOpenListCard(double cardHight, double cardWidth, int index) {
    return Container(
      // width: MediaQuery.of(context).size.width - cardWidth - 20,
      height: cardHight,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: cardWidth,
            height: cardHight,
            child: Image.asset(
              "assets/images/shinji.jpg",
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionBufferHeight(),
              Flexible(
                child: Container(
                  width: 200,
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    _searchViewModel.listFilterShopFuture![index].shopName
                        .toString(),
                    style: kfontH2InterBlackColor(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              _sectionBufferHeight(),
              RichText(
                // textAlign: TextAlign.center,
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.amber,
                    ),
                  ),
                  //TODO : Need to see how many people score for this shop
                  TextSpan(
                      text:
                          "${_searchViewModel.listFilterShopFuture![index].shopScore.toString()} (69) | 555km"),
                ], style: kfontH3InterBlackColor()),
              ),
              _sectionBufferHeight(bufferSection: 5),
              _sectionBufferHeight(bufferSection: 13),
              Text(
                "OPEN: ${DateFormat('HH:mm ').format(_searchViewModel.listFilterShopFuture![index].shopOpenTime)} " +
                    "| " +
                    "CLOSE: ${DateFormat('HH:mm ').format(_searchViewModel.listFilterShopFuture![index].shopCloseTime)} ",
                style: kfontH4InterBlackColor(),
              ),
              // Text(
              //   ,
              //   style: kfontH4Inter(),
              // )
            ],
          )
        ],
      ),
    );
  }

  Container shopCloseListCard(double cardHight, double cardWidth, int index) {
    return Container(
      // width: MediaQuery.of(context).size.width - cardWidth - 20,
      height: cardHight,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(3),
          border: Border.all(width: 1,color: Colors.black.withOpacity(0.5)),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: cardWidth,
            height: cardHight,
            child: Image.asset(
              "assets/images/shinji.jpg",
              color: Colors.white.withOpacity(0.3),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionBufferHeight(),
              Flexible(
                child: Container(
                  width: 200,
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    _searchViewModel.listFilterShopFuture![index].shopName
                        .toString(),
                    style: kfontH2InterBlackColorHalfOpacity(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              _sectionBufferHeight(),
              RichText(
                // textAlign: TextAlign.center,
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.amber,
                    ),
                  ),
                  //TODO : Need to see how many people score for this shop
                  TextSpan(
                      text:
                          "${_searchViewModel.listFilterShopFuture![index].shopScore.toString()} (69) | 555km"),
                ], style: kfontH3InterBlackColorHalfOpacity()),
              ),
              _sectionBufferHeight(bufferSection: 5),
              _sectionBufferHeight(bufferSection: 13),
              Text(
                "OPEN: ${DateFormat('HH:mm ').format(_searchViewModel.listFilterShopFuture![index].shopOpenTime)} " +
                    "| " +
                    "CLOSE: ${DateFormat('HH:mm ').format(_searchViewModel.listFilterShopFuture![index].shopCloseTime)} ",
                style: kfontH4InterBlackColorHalfOpacity(),
              ),
              // Text(
              //   ,
              //   style: kfontH4Inter(),
              // )
            ],
          )
        ],
      ),
    );
  }
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

//  ListTile(
//               shape: RoundedRectangleBorder(
//                   side: BorderSide(width: 2, color: Colors.amberAccent),
//                   borderRadius: BorderRadius.circular(10)),
//               leading: Container(
//                 width: 100,
//                 height: 150,
//                 child: FittedBox(
//                   fit: BoxFit.fill,
//                   child: Image.asset(
//                     "assets/images/background_crop.jpg",
//                     // scale: 1,
//                   ),
//                 ),
//               ),
//               //TODO Implement the images each list tiles
//               // leading: _searchViewModel.listFilterShopFuture![index].shopImage,
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(_searchViewModel.listFilterShopFuture![index].shopName),
//                 ],
//               ),
            