import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_application/data/widget/skelton_shimmer.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/model/menu.dart';
import 'package:coffee_application/model/response/customer_response.dart';
import 'package:coffee_application/model/review.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/screen/all_menu_shop.dart';
import 'package:coffee_application/screen/shop_edit_date_time.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:coffee_application/viewmodel/shop_information_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/data/widget/add_editing_image.dart';
import 'package:coffee_application/screen/my_component/buttom_navigationbar_shop.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShopInformationPage extends StatefulWidget {
  const ShopInformationPage({super.key});

  @override
  State<ShopInformationPage> createState() => _ShopInformationPageState();
}

class _ShopInformationPageState extends State<ShopInformationPage> {
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

  Map<String, dynamic> scoreFilterMapping = {
    "อาหาร": 4,
    "บริการ": 5,
    "สถานที่": 4,
    "ที่จอดรถ": 4,
    "เหมาะกับคุณไหม": false,
  };

  TextEditingController nameShop = TextEditingController();
  TextEditingController descriptionShop = TextEditingController();
  bool isEditingDescrition = false;
  bool isEditingShopName = false;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file;
  Uint8List webImage = Uint8List(10);

  late final ShopInformationVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = ShopInformationVM();
    _vm.onUserEnterShopInformation();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const ShopBottomNavigationBar(
          pageName: "HOME",
        ),
        body: FutureBuilder<ShopModel>(
            future: _vm.shopModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return shimmerWaitingCarousel(height, width);
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
                addCategoryWidget(categoryWidgets, shop.noice! == "QUITE_NOICE",
                    "SHOP_CATEGORY.QUITE_NOICE");

                return Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(backgroundImagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: backGroundApplication,
                          elevation: 0,
                          floating:
                              false, // Set to true if you want the app bar to float
                          // pinned: true,
                          expandedHeight: 250.0,
                          flexibleSpace: FlexibleSpaceBar(
                              background: FutureBuilder(
                            future: _vm.shopGetImagePathNetworkFromMinio(
                                shopId: shop.iId!, objectName: "coverImage"),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return Text("ERROR_MESSAGE.ERROR_LOADING_FAIL")
                                    .tr();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.data != null) {
                                return snapshot.data!.isNotEmpty
                                    ? Image.network(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            // You can display a loading indicator or progress bar here if needed.
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                              ),
                                            );
                                          }
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                          // You can handle the error here and display a placeholder or custom error widget.
                                          return Image.asset(imageNotFound);
                                        },
                                      )
                                    : Image.asset(imageNotFound);
                              }
                              return Container();
                            },
                          )),

                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(10),
                            child: Transform.translate(
                              offset: Offset(width * 0.45, 0),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  // color: brownBorderButto1n,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: IconButton(
                                  style: const ButtonStyle(
                                      shadowColor: MaterialStatePropertyAll(
                                          Color.fromARGB(96, 160, 131, 131))),
                                  splashColor: brownBorderButton,
                                  icon: const Icon(
                                    Icons.edit,
                                    color: backGroundApplication,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  onPressed: () async {
                                    try {
                                      XFile? value = await uploadImage();

                                      if (value != null) {
                                        XFile _xfile = value;
                                        await _vm.onUserAddCoverImageShop(
                                          shopId: shop.iId!,
                                          coverImage: File(_xfile.path).path,
                                          coverImageXfile: _xfile,
                                        );

                                        // Wait for the server to update the image
                                        await _waitForImageUpdate(shop.iId!);

                                        // Now you can update the UI or do any additional tasks
                                        setState(() {
                                          _vm.shopGetImagePathNetworkFromMinio(
                                            shopId: shop.iId!,
                                            objectName: "coverImage",
                                          );
                                        });
                                      }
                                    } catch (error) {
                                      // Handle any errors that might occur during the process
                                      print("Error: $error");
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate([
                          sectionBufferHeight(bufferSection: 20),
                          Stack(
                            children: [
                              _shopName(
                                shop: shop,
                                width: width,
                                height: height,
                                shopName: nameShop,
                              ),
                              Positioned(
                                left: width * 0.78,
                                top: !isEditingShopName ? 0 : height * 0.01,
                                child: IconButton(
                                  splashColor: brownBorderButton,
                                  icon: !isEditingShopName
                                      ? const Icon(Icons.edit,
                                          color: backGroundApplication,
                                          shadows: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                                spreadRadius: 2,
                                              )
                                            ])
                                      : const Icon(Icons.check,
                                          color: Colors.black,
                                          shadows: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                                spreadRadius: 2,
                                              )
                                            ]),
                                  onPressed: () {
                                    setState(() {
                                      isEditingShopName = !isEditingShopName;
                                      if (isEditingShopName) {
                                        nameShop.text = shop.name ?? "";
                                      } else {
                                        shop.name = nameShop.text;
                                        _vm.onUserAddShopName(name: shop.name!);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              shop.reviewNum == 0
                                  ? Container()
                                  : Icon(
                                      Icons.star,
                                      size: width * 0.05,
                                      color: Colors.amber,
                                    ),
                              Text(
                                "${shop.reviewScoreMean == 0 ? "" : shop.reviewScoreMean!.toStringAsFixed(1)} ${shop.reviewNum == 0 ? "" : "(${shop.reviewNum.toString()})"}",
                                style: kfontH2InterBoldBlackColor(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                              ),
                            ],
                          ),
                          _shopAddress(
                            height,
                            shop,
                            context,
                            () {
                              setState(
                                () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return EditDateTime(
                                      shop: shop,
                                    );
                                  })).then(
                                    (value) {
                                      print("value");
                                      print(value);
                                      if (value) {
                                        setState(
                                          () {
                                            _vm.onUserAddTimeOpenAndClose(
                                                openDays: shop.daysOpen!,
                                                openTime: shop.timeOpen!,
                                                closeTime: shop.timeClose!);
                                          },
                                        );
                                      } else {
                                        setState(() {});
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          sectionBufferHeight(bufferSection: 20),
                          _shopDescription(width: width, shop: shop),
                          sectionBufferHeight(bufferSection: 10),
                          _categoryShopSection(categoryWidgets),
                          sectionBufferHeight(bufferSection: 20),
                          _shopImageIconSection(context, shop),
                          sectionBufferHeight(bufferSection: 5),
                          _imageOfShopSection(shop),
                          // _imageslider(context,
                          //     usingImagesList(context: context, shop: shop)),
                          sectionBufferHeight(bufferSection: 20),
                          _menuHeader(context, shop),
                          sectionBufferHeight(bufferSection: 20),
                          _menuCarouselSliderList(shop, width, height),
                          // sectionBufferHeight(bufferSection: 30),
                          // sectionBufferHeight(bufferSection: height * 0.015),
                          headingContainer(
                              header: "SHOP_PAGE_VIEW.LATEST_REVIEW".tr()),
                          sectionBufferHeight(bufferSection: height * 0.015),

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
                              _vm.customerList
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
                                      begin: const Alignment(-1, -1),
                                      end: const Alignment(1, 1),
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
                                List<ReviewModel> reviewList =
                                    snapshot.data![0];
                                List<CustomerModelResponse> customerList =
                                    snapshot.data![1];

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
                                    CustomerModelResponse? customer =
                                        customerList.firstWhere(
                                      (element) =>
                                          element.iId == review.iCustomerId,
                                      orElse: () => CustomerModelResponse(
                                        name: "No Name",
                                      ),
                                    );

                                    return containerReviewListCard(
                                      reviewerName: customer.name ?? "",
                                      flavourScore: review.flavour ?? 0,
                                      placeScore: review.place ?? 0,
                                      serviceScore: review.service ?? 0,
                                      parkingScore: review.parking ?? 0,
                                      worthinessScore: review.worthiness ?? 0,
                                      comment: review.comment ?? "",
                                      timestamp: review.timestamp ?? "",
                                      menuID: review.iMenuId ?? 0,
                                      shop: shop,
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
                    ));
              }
              print("snapshot.error");
              print(snapshot.error);
              return Container();
            }),
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
      required int menuID,
      required ShopModel shop}) {
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
          // sectionBufferHeight(bufferSection: 30),
          // menuPriceReviewSection(
          //   menu: shop.menus!.firstWhere((menu) => menu. == menuID),
          // ),
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
              // Expanded(
              //   flex: 3,
              //   child: Container(
              //     height: 125,
              //     decoration: ShapeDecoration(
              //       image: const DecorationImage(
              //         image: AssetImage(americanoImagePath),
              //         fit: BoxFit.fill,
              //       ),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       shadows: [
              //         const BoxShadow(
              //           color: Color(0x3F000000),
              //           blurRadius: 4,
              //           offset: Offset(0, 4),
              //           spreadRadius: 0,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }

  Future<Uint8List> _pathToUnit8(String filePath) async {
    XFile file = XFile(filePath);
    var f = await file.readAsBytes();
    return f;
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

  FutureBuilder _menuCarouselSliderList(
      ShopModel shop, double width, double height) {
    return FutureBuilder(
      future: _vm.shopGetMenuImageFromMinio(shop: shop, objectName: "menus"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(),
          );
        } else if (snapshot.hasError) {
          return Text("ERROR_MESSAGE.ERROR_LOADING_FAIL");
        } else if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError &&
            snapshot.data != null) {
          return CarouselSlider.builder(
            itemCount: shop.menus!.isEmpty ? 1 : shop.menus!.length,
            options: CarouselOptions(
              height: height * 0.3,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
            itemBuilder: (context, index, realIndex) {
              return shop.menus!.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      decoration: kdecorationButtonSelectedOrange,
                      child: Text(
                        " คุณยังไม่มีเมนูเลยนะ",
                        style: kfontH0InterBlackColor(),
                      ),
                    )
                  : menuCard(
                      width: width,
                      height: height,
                      menu: shop.menus![index],
                      image: snapshot.data![index]);
            },
          );
        }
        return Container();
      },
    );
  }

  Row _menuHeader(BuildContext context, ShopModel shop) {
    return Row(
      children: [
        headingContainer(header: "เมนู"),
        const Spacer(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: brownBorderButton,
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            splashColor: brownBorderButton,
            icon: const Icon(
              Icons.edit,
              color: backGroundApplication,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AllMenuShopPage(
                    shop: shop,
                  );
                },
              )).then((value) {
                setState(() {
                  _vm.onUserAddEditShopMenu(
                    menu: shop.menus!,
                    shopId: shop.iId!,
                  );
                });
              });
            },
          ),
        ),
      ],
    );
  }

  Row _imageslider(BuildContext context, List<XFile> selectedImagesList) {
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

  Container _shopImageIconSection(BuildContext context, ShopModel shop) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Row(
        children: [
          for (var category in ["Home", "Menu", "Food", "Other"])
            GestureDetector(
              onTap: () {
                setState(() {
                  for (var key in listOfImageShopButton.keys) {
                    listOfImageShopButton[key] = (key == category);
                  }
                  _current = 1;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: listOfImageShopButton[category]!
                      ? selectButtonColor
                      : backgroundActiveButton,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  _getIconForCategory(category),
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: brownBorderButton,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              splashColor: brownBorderButton,
              icon: const Icon(
                Icons.edit,
                color: backGroundApplication,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => AddEditingImagesShopList(
                      shop: shop,
                      callBackFunction: callbackSetStateFunction,
                      isHaveShopAlready: true,
                    ),
                  ),
                )
                    .then((value) {
                  _vm
                      .onUserAddImagesShop(
                        shopId: shop.iId!,
                        shopImages: value["shopImages"],
                        menuImages: value["menuImages"],
                        foodImages: value["foodImages"],
                        otherImages: value["otherImages"],
                      )
                      .then(
                        (value) => _waitForImageUpdate(shop.iId!).then(
                          (value) {
                            setState(
                              () {
                                _vm.shopGetImageShop(
                                    shop: shop, objectName: findObjectName());
                              },
                            );
                          },
                        ),
                      );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case "Home":
        return Icons.home_outlined;
      case "Menu":
        return Icons.menu_book_outlined;
      case "Food":
        return Icons.coffee_rounded;
      case "Other":
        return Icons.battery_charging_full_outlined;
      default:
        return Icons.error;
    }
  }

  FutureBuilder _imageOfShopSection(ShopModel shop) {
    return FutureBuilder(
        future: _vm.shopGetImageShop(shop: shop, objectName: findObjectName()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ERROR_MESSAGE.ERROR_LOADING_FAIL").tr();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return CarouselSlider.builder(
              itemCount: snapshot.data!.isEmpty ? 1 : snapshot.data!.length,
              options: CarouselOptions(
                // height: 200,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                scrollPhysics: const BouncingScrollPhysics(),
              ),
              itemBuilder: (context, index, realIndex) {
                return snapshot.data!.isEmpty
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
                            child: FadeInImage(
                                image: NetworkImage(snapshot.data![index]),
                                fit: BoxFit.fitHeight,
                                placeholder: AssetImage(imageNotFound))),
                      );
              },
            );
          }
          return Container();
        });
  }

  Container _categoryShopSection(List<Widget> categoryWidgets) {
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

  List<XFile> pathToXFileList(List<String> listPath) {
    List<XFile> listXFile = [];
    for (String path in listPath) {
      listXFile.add(XFile(path));
    }
    return listXFile;
  }

  Stack _shopDescription({required double width, required ShopModel shop}) {
    return Stack(
      children: [
        Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: backgroundActiveButton,
            ),
            child: !isEditingDescrition
                ? SizedBox(
                    width: width,
                    child: Text(
                      shop.description ?? "",
                      maxLines: 3,
                      style: kfontH2InterBlackColor(),
                    ),
                  )
                : SizedBox(
                    width: width,
                    child: TextField(
                      maxLines: 3,
                      controller: descriptionShop,
                      onChanged: (value) {
                        shop.description = value;
                      },
                      style: kfontH2InterBlackColor(),
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Hide underline
                      ),
                    ),
                  )),
        Positioned(
          bottom: 10.0, // Adjust the bottom margin as needed
          right: 30.0, // Adjust the right margin as needed
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: brownBorderButto1n,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              splashColor: brownBorderButton,
              icon: !isEditingDescrition
                  ? const Icon(Icons.edit,
                      color: backGroundApplication,
                      shadows: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ])
                  : const Icon(
                      Icons.check,
                      color: backGroundApplication,
                    ),
              onPressed: () {
                setState(() {
                  isEditingDescrition = !isEditingDescrition;
                  if (isEditingDescrition) {
                    descriptionShop.text = shop.description ?? "";
                  } else {
                    shop.description = descriptionShop.text;
                    _vm.onUserAddShopDescription(
                        description: shop.description!);
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Center _shopName(
      {required ShopModel shop,
      required width,
      required height,
      required TextEditingController shopName}) {
    return Center(
        child: !isEditingShopName
            ? Text(
                shop.name ?? "",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
                style: kfontH0InterBlackColor(),
              )
            : SizedBox(
                width: width,
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  controller: shopName,
                  onChanged: (value) {
                    shop.name = value;
                  },
                  style: kfontH0InterBlackColor(),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Hide underline
                  ),
                ),
              ));
  }

  Shimmer shimmerWaitingCarousel(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
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
      ),
    );
  }

  GestureDetector _shopAddress(
      double height, ShopModel shop, BuildContext context, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
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
      ),
    );
  }

  void addCategoryWidget(
      List<Widget> categoryWidgets, bool condition, String categoryName) {
    if (condition) {
      categoryWidgets.add(containerCategoryBox(categoryName: categoryName));
    }
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

  Container menuPriceReviewSection({
    required Menus menu,
  }) {
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
          const Spacer(
            flex: 2,
          ),
          Flexible(
            flex: 3,
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

  Container scoreReviewSection(
      {required String title, required dynamic score}) {
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
                  "CHART.DAY_OF_WEEK.$title".tr(),
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
              child: score.runtimeType == bool
                  ? (score
                      ? const Icon(Icons.sentiment_satisfied_outlined)
                      : const Icon(Icons.sentiment_dissatisfied_outlined))
                  : Text(
                      score.toString(),
                      style: kfontH0InterBlackColor(),
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

  SizedBox menuCard(
      {required double width,
      required double height,
      required Menus menu,
      required String image}) {
    return SizedBox(
      width: width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 100,
            child: Container(
              width: width * 0.6,
              height: height * 0.175,
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
              child: Column(children: [
                const Spacer(),
                Text(menu.name ?? "",
                    textAlign: TextAlign.center, style: kfontNameMenu()),
                Text(menu.category ?? "",
                    textAlign: TextAlign.center, style: kfontMenuDescription()),
                Text("${menu.price.toString()} ฿",
                    textAlign: TextAlign.center, style: kfontMenuPrice()),
                sectionBufferHeight(
                  bufferSection: height * 0.025,
                )
              ]),
            ),
          ),
          Positioned(
            // left: 70,
            top: 20,
            child: Container(
              width: 150,
              height: 150,
              decoration: ShapeDecoration(
                // image: DecorationImage(
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
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      // You can display a loading indicator or progress bar here if needed.
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    // You can handle the error here and display a placeholder or custom error widget.
                    return Image.asset(imageNotFound);
                  },
                ),
              ),
            ),
          )
        ],
      ),
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

  Future<Uint8List> _xfileToUnit8(XFile file) async {
    var f = await file.readAsBytes();
    return f;
  }

  Future uploadImage() async {
    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        XFile selected = image;

        setState(() {
          _file = selected;
        });
        return _file;
      } else {
        Utility.toastMessage("ERROR_MESSAGE.PLEASE_SELECT_IMAGE".tr());
      }
    }
    // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          _file = image;
          webImage = f;
        });
        return _file;
      } else {
        Utility.toastMessage("ERROR_MESSAGE.PLEASE_SELECT_IMAGE".tr());
      }
    } else {
      Utility.toastMessage("ERROR_MESSAGE.PERMISSION_NOT_GRANTED".tr());
    }
  }

  String findObjectName() {
    for (var entry in listOfImageShopButton.entries) {
      if (entry.value == true) {
        switch (entry.key) {
          case "Home":
            return "shopimages";
          case "Menu":
            return "menuimages";
          case "Food":
            return "foodimages";
          case "Other":
            return "otherimages";
        }
      }
    }
    return "";
  }

  Future<void> _waitForImageUpdate(int shopId) async {
    const maxAttempts = 5;
    const delayDuration = Duration(milliseconds: 2000);

    for (int attempt = 1; attempt <= maxAttempts;) {
      await Future.delayed(delayDuration);

      bool
          isImageUpdated = /* Check whether the image is updated on the server */
          true;

      if (isImageUpdated) {
        return; // Image update is complete, exit the loop
      }
    }

    // Handle the case when the image update takes too long
    print("Image update took too long");
  }
}
