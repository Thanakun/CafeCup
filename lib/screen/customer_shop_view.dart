import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_application/data/widget/add_editing_image.dart';
import 'package:coffee_application/data/widget/skelton_shimmer.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/response/promotion.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/screen/customer_promotion.dart';
import 'package:coffee_application/screen/my_component/bottom_navigationbar_customer.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/customer_shop_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class CustomerShopView extends StatefulWidget {
  const CustomerShopView({super.key, required this.shopId});

  final int shopId;

  @override
  State<CustomerShopView> createState() => _CustomerShopViewState();
}

class _CustomerShopViewState extends State<CustomerShopView> {
  late CustomerOnShopVM _vm;

  Map<String, bool> listOfImageShopButton = {
    "Home": true,
    "Menu": false,
    "Food": false,
    "Other": false
  };

  List<String> shopListCategory = [
    "โต๊ะเดี่ยว",
    "โต๊ะคู่",
    "โต๊ะใหญ่",
    "Wifi",
    "ปลั๊ก",
    "ห้องประชุม",
    "โซนเงียบ",
    "โซนปกติ"
  ];

  Map<String, bool> filterTimelineMap = {
    "Most Recent": true,
    "Oldest": false,
  };

  bool isSelectedAllReview = true;
  Map<int, bool> scoreIsSelectMap = {
    1: false,
    2: false,
    3: false,
    4: false,
    5: false
  };

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    _vm = CustomerOnShopVM();
    _vm.onUserEnterTheShopPage(shopID: widget.shopId);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: const CustomerNavigationBar(
          pageName: "SHOP",
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<ShopModel>(
              future: _vm.shopModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return shimmerWaitingCarousel(height, width);
                } else if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: width * 0.5,
                          height: height * 0.1,
                          decoration: kdecorationForContainerBackButton,
                          child: Text(
                            "Back",
                            style: kfont26Bold_400(),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "ERROR_MESSAGE.ERROR_LOADING_FAIL".tr(),
                          style: kfont32_400(),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError) {
                  List<Widget> categoryWidgets = [];
                  ShopModel shop = snapshot.data!;
                  addCategoryWidget(categoryWidgets, shop.singleSeat! > 0,
                      "SHOP_CATEGORY.SINGLE_SEAT");
                  addCategoryWidget(categoryWidgets, shop.doubleSeat! > 0,
                      "SHOP_CATEGORY.DOUBLE_SEAT");
                  addCategoryWidget(categoryWidgets, shop.largeSeat! > 0,
                      "SHOP_CATEGORY.LARGE_SEAT");
                  addCategoryWidget(
                      categoryWidgets, shop.wifi!, "SHOP_CATEGORY.WIFI");
                  addCategoryWidget(categoryWidgets, shop.powerPlugs!,
                      "SHOP_CATEGORY.POWER_PLUGS");
                  addCategoryWidget(categoryWidgets, shop.conferenceRoom!,
                      "SHOP_CATEGORY.CONFERENCE_ROOM");
                  addCategoryWidget(
                      categoryWidgets, shop.toilet!, "SHOP_CATEGORY.TOILET");
                  addCategoryWidget(categoryWidgets, shop.smokingZone!,
                      "SHOP_CATEGORY.SMOKING_ZONE");
                  addCategoryWidget(categoryWidgets, shop.noice! == "NORMAL",
                      "SHOP_CATEGORY.NORMAL_NOICE");
                  addCategoryWidget(
                      categoryWidgets,
                      shop.noice! == "QUITE_NOICE",
                      "SHOP_CATEGORY.QUITE_NOICE");

                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: backGroundApplication,
                        elevation: 0,
                        expandedHeight: 200.0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: shop.coverImage == null
                              ? const Image(
                                  image: AssetImage(imageNotFound),
                                  fit: BoxFit.cover,
                                )
                              : Image.file(File(shop.coverImage!)),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        sectionBufferHeight(bufferSection: 20),
                        _shopNameSection(shop),
                        sectionBufferHeight(bufferSection: 20),
                        _shopAddress(height, shop, context),
                        sectionBufferHeight(bufferSection: 20),
                        _shopDescriptionSection(shop),
                        sectionBufferHeight(bufferSection: 20),
                        _shopCategorySection(categoryWidgets),
                        sectionBufferHeight(bufferSection: 20),
                        _shopImageButton(shop: shop),
                        sectionBufferHeight(bufferSection: 5),
                        _imageSliderSection(usingImagesList(
                          listImageShop: shop.shopImage ?? [],
                          listImageMenu: shop.menuImages ?? [],
                          listImageFood: shop.foodImages ?? [],
                          listImageOther: shop.otherImages ?? [],
                        )),
                        _carouselSlider(
                            context,
                            usingImagesList(
                              listImageShop: shop.shopImage ?? [],
                              listImageMenu: shop.menuImages ?? [],
                              listImageFood: shop.foodImages ?? [],
                              listImageOther: shop.otherImages ?? [],
                            )),
                        sectionBufferHeight(bufferSection: 20),
                        Row(
                          children: [
                            headingContainer(header: "เมนู"),
                          ],
                        ),
                        sectionBufferHeight(bufferSection: 20),
                        CarouselSlider.builder(
                          itemCount: shop.menus!.length,
                          options: CarouselOptions(
                            height: 300,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            scrollPhysics: const BouncingScrollPhysics(),
                          ),
                          itemBuilder: (context, index, realIndex) {
                            return menuCard(
                                width: width, menu: shop.menus![index]);
                          },
                        ),
                        sectionBufferHeight(bufferSection: 30),
                        FutureBuilder(
                            future: _vm.promotionListModel,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else if (snapshot.hasError) {
                                Center(
                                    child: Text(
                                            "ERROR_MESSAGE.ERROR_LOADING_FAIL",
                                            style: kfont32_400())
                                        .tr());
                              } else if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  !snapshot.hasError) {
                                List<Promotion> customerPromotionShopList =
                                    snapshot.data!.where(
                                  (e) {
                                    return e.iShopId == shop.iId;
                                  },
                                ).toList();
                                print(snapshot.data);
                                return customerPromotionShopList.isNotEmpty
                                    ? Container(
                                        width: width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.015,
                                            vertical: height * 0.015),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: width * 0.07281),
                                        decoration: BoxDecoration(
                                          color: backgroundActiveButton,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: colorRedBackGroundIcon,
                                              width: 2),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        width * 0.015),
                                                    decoration:
                                                        kdecorationIconContainer,
                                                    child: Icon(
                                                        IconlyLight.discount,
                                                        size: height * 0.035,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: width * 0.1),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "PROMOTION.YOU_HAVE_CODE_AVALIABLE"
                                                            .tr(),
                                                        style:
                                                            kfontH0InterBlackColor(),
                                                      ),
                                                      sectionBufferHeight(
                                                          bufferSection:
                                                              height * 0.015),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                              width * 0.015,
                                                          vertical:
                                                              height * 0.015,
                                                        ),
                                                        decoration:
                                                            kdecorationForContainerApplication,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.015,
                                                              ),
                                                              child: Text(
                                                                shop.name ??
                                                                    "ERROR_MESSAGE.SHOP_NAME_EMPTY"
                                                                        .tr(),
                                                                style:
                                                                    kfont26_400(),
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.015,
                                                              ),
                                                              child: Text(
                                                                //TODO PROMOTION DETAIL
                                                                "ลดราคา เครื่องดื่ม 10 บาท",
                                                                style:
                                                                    kfontH2InterBoldBlackColor(),
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.015,
                                                              ),
                                                              child: Text(
                                                                //TODO PROMOTION DETAIL
                                                                "วันหมดอายุ: ${Helper.getDisplayTimeDate(customerPromotionShopList[0].dateExpired!)}",
                                                                style:
                                                                    kfontH2InterBlackColor(),
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      sectionBufferHeight(
                                                          bufferSection:
                                                              height * 0.015),
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            //TODO GO TO PROMOTION PAGE
                                                            Navigator
                                                                .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return CustomerPromotionView();
                                                              },
                                                            ));
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal:
                                                                  width * 0.05,
                                                              vertical: height *
                                                                  0.015,
                                                            ),
                                                            decoration:
                                                                kdecorationForContainerAcceptButton,
                                                            child: Text(
                                                              "BUTTON.GOTO_PROMOTION",
                                                              style:
                                                                  kfontH1InterBoldBlackColor(),
                                                            ).tr(),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )
                                    : Container();
                              }
                              return Container();
                            }),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        headingContainer(
                            header: "SHOP_PAGE_VIEW.LATEST_REVIEW".tr()),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              //TODO ADD NAVIGATE TO REVIEW PAGE
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                  vertical: height * 0.015),
                              decoration:
                                  kdecorationForContainerActiveBeingSelected,
                              child: Text(
                                "SHOP_PAGE_VIEW.ADDING_MY_REVIEW",
                                style: kfontH1InterBoldWhiteColor(),
                              ).tr(),
                            ),
                          ),
                        ),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStarContainer(
                                isSelected: isSelectedAllReview,
                                label: "All",
                                onTap: () {
                                  setState(() {
                                    isSelectedAllReview = true;
                                    scoreIsSelectMap.forEach((key, value) {
                                      scoreIsSelectMap[key] = false;
                                    });
                                  });
                                },
                              ),
                              ...scoreIsSelectMap.entries.map(
                                (score) => buildStarContainer(
                                  isSelected: score.value,
                                  score: score.key,
                                  onTap: () {
                                    setState(() {
                                      // Toggle the selection state for individual stars
                                      scoreIsSelectMap.forEach((key, value) {
                                        scoreIsSelectMap[key] =
                                            key == score.key;
                                      });

                                      // If any individual star is selected, set "All" to false
                                      isSelectedAllReview = false;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        sectionBufferHeight(bufferSection: 20),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 60, right: 60, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...filterTimelineMap.entries.map(
                                (e) {
                                  return filterTimelineContainer(
                                      nameContainerFilter: e.key,
                                      onTap: () {
                                        setState(() {
                                          filterTimelineMap
                                              .forEach((key, value) {
                                            filterTimelineMap[key] =
                                                key == e.key;
                                          });
                                        });
                                      },
                                      isSelected: e.value);
                                },
                              )
                            ],
                          ),
                        ),
                        sectionBufferHeight(bufferSection: 20),
                        FutureBuilder(
                          future: Future.wait([
                            _vm.reviewList,
                            _vm.customerModel
                          ] as Iterable<Future>),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Shimmer(
                                  child: Skeleton(
                                    width: double.infinity,
                                    height: height,
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey[300]!,
                                      Colors.grey[100]!
                                    ], // Adjust colors as needed
                                    begin: Alignment(-1, -1),
                                    end: Alignment(1, 1),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  "ERROR_MESSAGE.ERROR_LOADING_FAIL",
                                ),
                              );
                            } else if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                !snapshot.hasError) {
                              List<ReviewModel> reviewList = snapshot.data![0];
                              CustomerModel currentCustomer = snapshot.data![1];

                              List<ReviewModel> displayList;

                              if (filterTimelineMap["Most Recent"]!) {
                                // Sort in descending order based on timestamp
                                displayList = List.from(reviewList);
                                displayList.sort((a, b) =>
                                    b.timestamp!.compareTo(a.timestamp!));
                                displayList = displayList.take(5).toList();
                              } else if (filterTimelineMap["Oldest"]!) {
                                // Sort in ascending order based on timestamp
                                displayList = List.from(reviewList);
                                displayList.sort((a, b) =>
                                    a.timestamp!.compareTo(b.timestamp!));
                                if (displayList.length > 5) {
                                  displayList = displayList
                                      .skip(displayList.length - 5)
                                      .toList();
                                }
                              } else {
                                // Handle other cases or set displayList to the original list
                                displayList = List.from(reviewList);
                              }

                              return Column(
                                children: displayList.map((review) {
                                  return containerReviewListCard(
                                    reviewerName: currentCustomer.name ?? "",
                                    flavourScore: review.flavour ?? 0,
                                    placeScore: review.place ?? 0,
                                    serviceScore: review.service ?? 0,
                                    parkingScore: review.parking ?? 0,
                                    worthinessScore: review.worthiness ?? 0,
                                    comment: review.comment ?? "",
                                    timestamp: review.timestamp ?? "",
                                    menuID: review.iMenuId ?? 0,
                                  );
                                }).toList(),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )
                      ]))
                    ],
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }

  Row _carouselSlider(BuildContext context, List<XFile> selectedImagesList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: selectedImagesList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 12.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }

  CarouselSlider _imageSliderSection(
    List<XFile> selectedImagesList,
  ) {
    return CarouselSlider.builder(
      itemCount: selectedImagesList.isEmpty ? 1 : selectedImagesList.length,
      options: CarouselOptions(
          // height: 200,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          scrollPhysics: const BouncingScrollPhysics(),
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
      itemBuilder: (context, index, realIndex) {
        return selectedImagesList.isEmpty
            ? Container(
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: backgroundActiveButton,
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            : Container(
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: backgroundActiveButton,
                  borderRadius: BorderRadius.circular(10),
                  // You can use Image.network or Image.file based on your image source
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  clipBehavior: Clip.hardEdge, //default is none
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Image.file(
                    File(selectedImagesList[index].path),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              );
      },
    );
  }

  Stack _shopDescriptionSection(ShopModel shop) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: backgroundActiveButton,
          ),
          child: Text(
            shop.description ?? "ERROR_MESSAGE.SHOP_DESCRIPTION_EMPTY".tr(),
            style: kfontH2InterBlackColor(),
          ),
        ),
      ],
    );
  }

  Center _shopNameSection(ShopModel shop) {
    return Center(
      child: Container(
        child: Text(
          shop.name ?? "ERROR_MESSAGE.SHOP_NAME_EMPTY".tr(),
          style: kfontH0InterBlackColor(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }

  Container _shopCategorySection(List<Widget> categoryWidgets) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 5,
          runSpacing: 5,
          children: categoryWidgets),
    );
  }

  Container _shopImageButton({required ShopModel shop}) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                listOfImageShopButton["Home"] = true;
                listOfImageShopButton["Menu"] = false;
                listOfImageShopButton["Food"] = false;
                listOfImageShopButton["Other"] = false;
                usingImagesList(
                  listImageShop: shop.shopImage ?? [],
                  listImageMenu: shop.menuImages ?? [],
                  listImageFood: shop.foodImages ?? [],
                  listImageOther: shop.otherImages ?? [],
                );
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: listOfImageShopButton["Home"]!
                      ? selectButtonColor
                      : backgroundActiveButton,
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                listOfImageShopButton["Home"] = false;
                listOfImageShopButton["Menu"] = true;
                listOfImageShopButton["Food"] = false;
                listOfImageShopButton["Other"] = false;
                usingImagesList(
                  listImageShop: shop.shopImage ?? [],
                  listImageMenu: shop.menuImages ?? [],
                  listImageFood: shop.foodImages ?? [],
                  listImageOther: shop.otherImages ?? [],
                );
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: listOfImageShopButton["Menu"]!
                      ? selectButtonColor
                      : backgroundActiveButton,
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(
                Icons.menu_book_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                listOfImageShopButton["Home"] = false;
                listOfImageShopButton["Menu"] = false;
                listOfImageShopButton["Food"] = true;
                listOfImageShopButton["Other"] = false;
                usingImagesList(
                  listImageShop: shop.shopImage ?? [],
                  listImageMenu: shop.menuImages ?? [],
                  listImageFood: shop.foodImages ?? [],
                  listImageOther: shop.otherImages ?? [],
                );
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: listOfImageShopButton["Food"]!
                      ? selectButtonColor
                      : backgroundActiveButton,
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(
                Icons.coffee_rounded,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                listOfImageShopButton["Home"] = false;
                listOfImageShopButton["Menu"] = false;
                listOfImageShopButton["Food"] = false;
                listOfImageShopButton["Other"] = true;
                usingImagesList(
                  listImageShop: shop.shopImage ?? [],
                  listImageMenu: shop.menuImages ?? [],
                  listImageFood: shop.foodImages ?? [],
                  listImageOther: shop.otherImages ?? [],
                );
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: listOfImageShopButton["Other"]!
                      ? selectButtonColor
                      : backgroundActiveButton,
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(
                Icons.battery_charging_full_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _shopAddress(double height, ShopModel shop, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(3, 10),
              blurRadius: 1,
              // spreadRadius: 1,
            ),
            BoxShadow(
              color: backGroundApplication,
              offset: Offset(-3, -3),
              blurRadius: 5,
              spreadRadius: 1,
            )
          ],
          border: Border.all(color: Colors.black, width: 2)),
      height: 150,
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                sectionBufferHeight(bufferSection: height * 0.01),
                const Icon(
                  Icons.access_time_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                sectionBufferHeight(bufferSection: height * 0.03),
                const Icon(
                  Icons.place_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionBufferHeight(bufferSection: height * 0.01),
                Text(
                  shop.daysOpen != null && shop.daysOpen!.isNotEmpty
                      ? "${Helper.getDisplayDayOfWeekOpenShop(shop.daysOpen!, Localizations.localeOf(context) == const Locale('th', 'TH'))}  ${shop.timeOpen} - ${shop.timeClose}\n${Helper.getDisplayDayOfWeekCloseShop(shop.daysOpen!, Localizations.localeOf(context) == const Locale('th', 'TH'))}  ร้านปิด"
                      : "\n ",
                  // "จ-ศ   10:00 - 20:00",
                  style: kfontH2InterBlackColor(),
                  // textAlign: TextAlign.center,
                ),
                sectionBufferHeight(bufferSection: height * 0.01),
                Text(
                  "ตำบล ${shop.address!.subDistrict!} ,อำเภอเมือง , จังหวัดเชียงใหม่ 50200 ",
                  style: kfontH2InterBlackColor(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container containerReviewListCard(
      {required String reviewerName,
      required int flavourScore,
      required int placeScore,
      required int serviceScore,
      required int parkingScore,
      required int worthinessScore,
      required String comment,
      required String timestamp,
      required int menuID}) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundActiveButton,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.red,
                ),
              ),
              Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    height: 80,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(reviewerName,
                              style: kfontH3InterBlackColor()),
                        ),
                        sectionBufferHeight(),
                        Container(
                          child: Text("${Helper.getDisplayTimeDate(timestamp)}",
                              style: kfontH3InterBlackColor()),
                        )
                      ],
                    ),
                  ))
            ],
          ),
          sectionBufferHeight(bufferSection: 10),
          reviewSectionValueScore(
              scoreTitle: "SHOP_PAGE_VIEW.FLAVOR_SCORE".tr(),
              score: flavourScore),
          reviewSectionValueScore(
              scoreTitle: "SHOP_PAGE_VIEW.PLACE_SCORE".tr(), score: placeScore),
          reviewSectionValueScore(
              scoreTitle: "SHOP_PAGE_VIEW.SERVICE_SCORE".tr(),
              score: serviceScore),
          reviewSectionValueScore(
              scoreTitle: "SHOP_PAGE_VIEW.PARKING_SCORE".tr(),
              score: parkingScore),
          reviewSectionValueScore(
              scoreTitle: "SHOP_PAGE_VIEW.WORTHINESS_SCORE".tr(),
              score: worthinessScore),
          sectionBufferHeight(bufferSection: 30),
          menuPriceReviewSection(),
          sectionBufferHeight(bufferSection: 30),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  height: 125,
                  child: SingleChildScrollView(
                    child: Text(
                      comment,
                      style: kfontH3InterBlackColor(),
                    ),
                  ),
                ),
              ),
              sectionBufferWidth(bufferSection: 10),
              Expanded(
                flex: 3,
                child: Container(
                  height: 125,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: AssetImage(americanoImagePath),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: [
                      const BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container reviewSectionValueScore({required scoreTitle, required int score}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  scoreTitle,
                  style: kfont26_400(),
                )),
          ),
          const Spacer(),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                score.toString(),
                style: kfontH0InterBlackColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container containerCategoryBox({required String categoryName}) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: backgroundActiveButton,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        categoryName.tr(),
        style: kfontH3InterBlackColor(),
      ),
    );
  }

  Container menuPriceReviewSection() {
    return Container(
      width: double.infinity,
      height: 60,
      // margin: EdgeInsets.only(
      //     left: 10, right: 10, top: 5, bottom: 5),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              child: Text(
                "อเมริการโน่ (Americano)",
                style: kfontH1Inter_400BlackColor(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 2,
            child: Container(
              child: Text(
                "ราคา 80 บาท",
                style: kfontH1Inter_400BlackColor(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector filterTimelineContainer(
      {required String nameContainerFilter,
      required Function onTap,
      required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? selectButtonColor : colorStarReviewUnSelect,
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Text(
          nameContainerFilter,
          style: kfontH3InterBlackColor(),
        ),
      ),
    );
  }

  Stack menuCard({required double width, required Menus menu}) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          // left: 0,
          top: 60,
          child: Container(
            width: 260,
            height: 180,
            decoration: ShapeDecoration(
              color: const Color(0xFFFFF5E9),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Colors.black.withOpacity(0.20000000298023224),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: [
                const BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
        ),
        Positioned(
          // left: 5,
          top: 129,
          child: SizedBox(
            width: 249,
            height: 30,
            child: Text(menu.name ?? "",
                textAlign: TextAlign.center, style: kfontNameMenu()),
          ),
        ),
        Positioned(
          // left: 5,
          top: 159,
          child: SizedBox(
            width: 249,
            height: 30,
            child: Text(menu.category ?? "",
                textAlign: TextAlign.center, style: kfontMenuDescription()),
          ),
        ),
        Positioned(
          // left: 79,
          top: 179,
          child: SizedBox(
            width: 102,
            height: 51,
            child: Text(menu.price == null ? "" : menu.price.toString(),
                textAlign: TextAlign.center, style: kfontMenuPrice()),
          ),
        ),
        Positioned(
          // left: 70,
          top: 0,
          child: Container(
            width: 120,
            height: 120,
            decoration: ShapeDecoration(
              // image: const DecorationImage(
              //   image: AssetImage(americanoImagePath),
              //   fit: BoxFit.fill,
              // ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: [
                const BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(menu.image!),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector buildStarContainer({
    required bool isSelected,
    int? score,
    String? label,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: isSelected ? selectButtonColor : colorStarReviewUnSelect,
          borderRadius: BorderRadius.circular(20),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <InlineSpan>[
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(0.0, 0.0),
                  child: Icon(
                    Icons.star_rate_rounded,
                    color: Colors.amber.shade400,
                    shadows: [
                      const BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                      ),
                      const BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-1, -1),
                      ),
                    ],
                  ),
                ),
              ),
              WidgetSpan(
                child: Text(
                  label ?? score.toString(),
                  style: kfontH3InterBlackColor(),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container headingContainer({required String header}) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
      child: Text(
        header,
        style: kfont26_400(),
        textAlign: TextAlign.left,
      ),
    );
  }

  void callbackSetStateFunction() {
    setState(() {});
  }

  List<XFile> pathToXFileList(List<String> listPath) {
    List<XFile> listXFile = [];
    for (String path in listPath) {
      listXFile.add(XFile(path));
    }
    return listXFile;
  }

  List<XFile> usingImagesList({
    required List<String> listImageShop,
    required List<String> listImageMenu,
    required List<String> listImageFood,
    required List<String> listImageOther,
  }) {
    if (listOfImageShopButton["Home"]!) {
      return pathToXFileList(listImageShop);
    } else if (listOfImageShopButton["Menu"]!) {
      return pathToXFileList(listImageMenu);
    } else if (listOfImageShopButton["Food"]!) {
      return pathToXFileList(listImageFood);
    } else if (listOfImageShopButton["Other"]!) {
      return pathToXFileList(listImageOther);
    }
    return [];
  }

  void addCategoryWidget(
      List<Widget> categoryWidgets, bool condition, String categoryName) {
    if (condition) {
      categoryWidgets.add(containerCategoryBox(categoryName: categoryName));
    }
  }

  Shimmer shimmerWaitingCarousel(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            width: width,
            height: height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.05),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: width * 0.5,
              height: height * 0.075,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.025),
          Container(
            width: width * 0.9,
            height: height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.025),
          Container(
            width: width * 0.9,
            height: height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.02),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 5,
            runSpacing: 5,
            children: [
              Container(
                width: width * 0.25,
                height: height * 0.04,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Container(
                width: width * 0.25,
                height: height * 0.04,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Container(
                width: width * 0.25,
                height: height * 0.04,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Container(
                width: width * 0.25,
                height: height * 0.04,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Container(
                width: width * 0.25,
                height: height * 0.04,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Container(
                width: width * 0.25,
                height: height * 0.04,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          sectionBufferHeight(bufferSection: height * 0.025),
          Container(
            margin: EdgeInsets.only(left: width * 0.05),
            alignment: Alignment.centerLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 5,
              runSpacing: 5,
              children: [
                Container(
                  width: width * 0.25,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: width * 0.25,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: width * 0.25,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: width * 0.25,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// SingleChildScrollView(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ),
//                                     Text.rich(
//                                       TextSpan(
//                                         children: [
//                                           WidgetSpan(
//                                             child: Icon(Icons.access_time),
//                                           ),
//                                           WidgetSpan(
//                                               child: sectionBufferWidth(
//                                                   bufferSection: width * 0.02)),
//                                           WidgetSpan(
//                                             child: Text(
//                                               shop.daysOpen != null &&
//                                                       shop.daysOpen!.isNotEmpty
//                                                   ? Helper
//                                                       .getDisplayDayOfWeekOpenShop(
//                                                           shop.daysOpen!,
//                                                           Localizations.localeOf(
//                                                                   context) ==
//                                                               const Locale(
//                                                                   'th', 'TH'))
//                                                   : " ",
//                                               // "จ-ศ   10:00 - 20:00",
//                                               style: kfontH2InterBlackColor(),
//                                               // textAlign: TextAlign.center,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Text(
//                                       shop.daysOpen != null &&
//                                               shop.daysOpen!.isNotEmpty
//                                           ? Helper.getDisplayDayOfWeekCloseShop(
//                                               shop.daysOpen!,
//                                               Localizations.localeOf(context) ==
//                                                   const Locale('th', 'TH'))
//                                           : " ",
//                                       // "ส-อา   11:00 - 18:00",
//                                       style: kfontH2InterBlackColor(),
//                                     ),
//                                     sectionBufferHeight(bufferSection: 20),
//                                     Text(
//                                       "ตำบล ${shop.address!.subDistrict!} ,อำเภอเมือง , จังหวัดเชียงใหม่ 50200 ",
//                                       // "ซอย 4 วัดอุโมงค์ บ้านหลิ่งห้า ตำบลสุเทพ, สุเทพ, เมือง, เชียงใหม่, 50200 ",
//                                       style: kfontH2InterBlackColor(),
//                                     )
//                                   ],
//                                 ),
//                               )
