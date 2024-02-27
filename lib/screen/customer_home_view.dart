import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_application/data/widget/skelton_shimmer.dart';
import 'package:coffee_application/model/customer_recommendation.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/screen/customer_shop_view.dart';
import 'package:coffee_application/screen/login.dart';
import 'package:coffee_application/screen/my_component/bottom_navigationbar_customer.dart';
import 'package:coffee_application/screen/customer_search_view.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/customer_home_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CustomerHomePageView extends StatefulWidget {
  const CustomerHomePageView({super.key});

  @override
  State<CustomerHomePageView> createState() => _CustomerHomePageViewState();
}

class _CustomerHomePageViewState extends State<CustomerHomePageView> {
  late CustomerHomeVM _vm;
  int _current = 0;
  @override
  void initState() {
    super.initState();
    _vm = CustomerHomeVM();
    _vm.getUserWhenEnteringTheRegisterPage();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const CustomerNavigationBar(
          pageName: "HOME",
        ),
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundCustomerHomeImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //make app bar here

                  shopAppBar(width),
                  shopTextFieldForm(),
                  Container(
                    margin: EdgeInsets.only(
                        left: width * 0.05, right: width * 0.05, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionBufferHeight(bufferSection: 16),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Text(
                            "CUSTOMER_HOME.CAFE_HOT".tr(),
                            style: kfont26Bold_400(),
                          ),
                        ),
                        sectionBufferHeight(bufferSection: 16),
                        FutureBuilder(
                          future: Future.wait([
                            _vm.listAllShopFuture,
                            _vm.listRecommendationShopFuture
                          ]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return shimmerWaitingCarousel(height, width);
                            } else if (snapshot.hasError) {
                              Text(
                                "ERROR_MESSAGE.ERROR_LOADING_FAIL",
                                style: kfont32_400(),
                              ).tr();
                            } else if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                !snapshot.hasError) {
                              _vm.getShopRecommendation(
                                  snapshot.data![0] as List<ShopModel>,
                                  snapshot.data![1]
                                      as List<CustomerRecommendation>);

                              return _carouselShopItem(
                                  height, _vm.matchedShops, width);
                            }
                            print(snapshot.connectionState);
                            print(snapshot.hasError);
                            print(snapshot.error);
                            return Container();
                          },
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Text(
                            "CUSTOMER_HOME.CAFE_CATEGORY".tr(),
                            style: kfont26Bold_400(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.03,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _imageContainerCategory(width, height),
                              _imageContainerCategory(width, height),
                              _imageContainerCategory(width, height),
                            ],
                          ),
                        ),
                        Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Text(
                            "CUSTOMER_HOME.CAFE_RECOMMENDED_FOR_YOU".tr(),
                            style: kfont26Bold_400(),
                          ),
                        ),
                        sectionBufferHeight(bufferSection: 16),
                        _futureListCarousel(
                            height: height,
                            width: width,
                            future: _vm.listAllShopFuture),
                        Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Text(
                            "CUSTOMER_HOME.CAFE_OTHER".tr(),
                            style: kfont26Bold_400(),
                          ),
                        ),
                        sectionBufferHeight(bufferSection: 16),
                        _futureListCarousel(
                            height: height,
                            width: width,
                            future: _vm.listAllShopFuture),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Shimmer shimmerWaitingCarousel(double height, double width) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: CarouselSlider(
          options: CarouselOptions(
            padEnds: false,
            height: height * 0.25,
            enableInfiniteScroll: false,
            viewportFraction: 0.77,
            aspectRatio: 2.0,
            initialPage: 0,
          ),
          items: [
            Container(
              margin: EdgeInsets.only(right: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: height * 0.01,
                    ),
                    width: width * 0.8,
                    height: height * 0.14,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey),
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: height * 0.01,
                          ),
                          width: constraints.maxWidth * 0.52,
                          height: height * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: height * 0.01,
                          ),
                          width: constraints.maxWidth * 0.3,
                          height: height * 0.01,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: height * 0.01,
                          ),
                          width: constraints.maxWidth * 0.15,
                          height: height * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey),
                        ),
                      ],
                    );
                  }),
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: height * 0.01,
                          ),
                          width: constraints.maxWidth * 0.42,
                          height: height * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey),
                        ),
                      ],
                    );
                  }),
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: height * 0.01,
                          ),
                          width: constraints.maxWidth * 0.32,
                          height: height * 0.01,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: height * 0.01,
                  ),
                  width: width * 0.8,
                  height: height * 0.14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey),
                ),
                LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: height * 0.01,
                        ),
                        width: constraints.maxWidth * 0.52,
                        height: height * 0.01,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: height * 0.01,
                        ),
                        width: constraints.maxWidth * 0.3,
                        height: height * 0.01,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: height * 0.01,
                        ),
                        width: constraints.maxWidth * 0.15,
                        height: height * 0.01,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey),
                      ),
                    ],
                  );
                }),
                LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: height * 0.01,
                        ),
                        width: constraints.maxWidth * 0.42,
                        height: height * 0.01,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey),
                      ),
                    ],
                  );
                }),
                LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: height * 0.01,
                        ),
                        width: constraints.maxWidth * 0.32,
                        height: height * 0.01,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ));
  }

  FutureBuilder<List<ShopModel>> _futureListCarousel(
      {required double height,
      required double width,
      required Future<List> future}) {
    return FutureBuilder<List<ShopModel>>(
      future: future as Future<List<ShopModel>>,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return shimmerWaitingCarousel(height, width);
        } else if (snapshot.hasError) {
          return Text(
            "ERROR_MESSAGE.ERROR_LOADING_FAIL",
            style: kfont32_400(),
          ).tr();
        } else if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return _carouselShopItem(height, snapshot.data!, width);
        }
        return Container();
      },
    );
  }

  CarouselSlider _carouselShopItem(
      double height, List<ShopModel> data, double width) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          padEnds: false,
          height: height * 0.25,
          enableInfiniteScroll: false,
          aspectRatio: 2.0,
          viewportFraction: 0.77,
          initialPage: 0,
          onPageChanged: (index, reason) {
            _current = index;
          }),
      itemCount: data.length,
      itemBuilder: (context, index, realIndex) {
        return LayoutBuilder(
          builder: (context, constraints) {
            ShopModel shop = data[index];
            return Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right: constraints.maxWidth * 0.05),
              width: constraints.maxWidth,
              height: height * 0.2,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: _shopSection(height, width, shop, constraints),
            );
          },
        );
      },
    );
  }

  Widget _shopSection(
      double height, double width, ShopModel shop, BoxConstraints constraints) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerShopView(
                shopId: shop.iId!,
              ),
            ));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shop.coverImage == null
                ? _imageShopForNullImage(height, width)
                : _imageShopForimage(height, width, shop),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: constraints.maxWidth * 0.6,
                  child: Text(
                    shop.name!,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kfontH1InterBoldBlackColor(),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: constraints.maxWidth * 0.1,
                  child: const Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.amber,
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,

                  width: constraints.maxWidth * 0.25,

                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.01),
                  //TODO SHOP SCORE AND TOTAL REVIEW
                  child: FittedBox(
                      child: Text(
                    "4.7 (5000)",
                    style: kfontH2InterBoldBlackColor(),
                  )),
                )
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      padding:
                          EdgeInsets.only(right: constraints.maxWidth * 0.05),
                      width: constraints.maxWidth * 0.9,
                      child: Text(
                        "\$\$\$ ${shop.wifi! ? "• Wifi" : ""} • ${shop.noice} ${shop.conferenceRoom! ? "• มีห้องประชุม" : ""} ${shop.powerPlugs! ? "• ปลั๊ก" : ""} ${shop.smokingZone! ? "• สูบบุหรี่" : ""} ${shop.toilet! ? "• ห้องน้ำ" : ""}",
                        softWrap: true,
                        style: kfontH2InterBoldBlackColor(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: constraints.maxWidth * 0.02),
                  child: Icon(
                    Icons.access_time_rounded,
                    size: constraints.maxHeight * 0.08,
                    color: Colors.black,
                  ),
                ),
                Container(
                    child: Text(
                  shop.timeOpen!,
                  style: kfontH2InterBoldBlackColor(),
                )),
                Container(
                    child: Text(
                  " - ${shop.timeClose}",
                  style: kfontH2InterBoldBlackColor(),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _imageShopForNullImage(
      double height, double width) {
    return Container(
      margin: EdgeInsets.only(
        bottom: height * 0.01,
      ),
      width: width,
      height: height * 0.14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, -3),
          )
        ],
        image: DecorationImage(
          image: const AssetImage(shopCoverImagePath) as ImageProvider<Object>,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container _imageShopForimage(double height, double width, ShopModel shop) {
    return Container(
      margin: EdgeInsets.only(
        bottom: height * 0.01,
      ),
      width: width,
      height: height * 0.14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, -3),
          )
        ],
      ),
      child: Image.file(File(shop.coverImage!)),
    );
  }

  Column _imageContainerCategory(double width, double height) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: width * 0.25,
          height: height * 0.115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, -3),
              )
            ],
            image: DecorationImage(
                image: AssetImage(
                  shopCoverImagePath,
                ),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          child: Text(
            "กลางแจ้ง",
            style: kfontH1InterBoldBlackColor(),
          ),
        ),
      ],
    );
  }

  Widget shopAppBar(double width) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        // margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 70,
        decoration: const BoxDecoration(
          color: backgroundActiveButton,
        ),
        child: Row(
          //make the Text Center and icon on the left
          children: [
            //make icon
            const Icon(
              Icons.coffee,
              size: 40,
            ),
            sectionBufferWidth(
              bufferSection: width * 0.29,
            ),
            Align(
              // text not fully height
              alignment: Alignment.center,
              child: FittedBox(
                // text

                fit: BoxFit.fitHeight,
                child: Text(
                  "Cafe Cup",
                  style: GoogleFonts.pacifico(
                    textStyle: kfont32_400(),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                ),
              ),
            ),
            //make icon
          ],
        ));
  }

  //make shoptextformfield()

  Widget shopTextFieldForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        color: backgroundActiveButton,
        border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
      ),
      child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          width: double.infinity,
          height: 50,
          decoration: kdecorationForContainerApplication,
          //Hide underline textfiled
          child: GestureDetector(
            onTap: () {
              //Navigate to search page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerSearchView()));
            },
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(),
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                      Icons.search,
                      size: 20,
                    )),
                    TextSpan(
                        text: "ค้นหา", style: kfontH2GreyColorHalfOpacity())
                  ],
                ),
              ),
            ),
          ) //make search icon
          ),
    );
  }
}
