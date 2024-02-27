import 'package:coffee_application/model/promotion.dart';
import 'package:coffee_application/screen/customer_barcode.dart';
import 'package:coffee_application/screen/my_component/bottom_navigationbar_customer.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/customer_promotion_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class CustomerPromotionView extends StatefulWidget {
  const CustomerPromotionView({super.key});

  @override
  State<CustomerPromotionView> createState() => _CustomerPromotionViewState();
}

class _CustomerPromotionViewState extends State<CustomerPromotionView> {
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  late final CustomerPromotionVM _vm;

  Map<String, bool> filterTimelineMap = {
    "Most Recent": true,
    "Oldest": false,
  };

  @override
  void initState() {
    super.initState();
    _vm = CustomerPromotionVM();
    _vm.onUserEnterThePromotionPage();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          bottomNavigationBar: const CustomerNavigationBar(
            pageName: "PROMOTION",
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(255, 245, 233, 1),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    top: height * 0.05,
                  ),
                  width: width,
                  height: height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "CUSTOMER_PROMOTION.PROMOTION_TITLE".tr(),
                            style: kfontH0InterBlackColor(),
                          ),
                        ),
                        sectionBufferHeight(bufferSection: height * 0.05),
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.05),
                          padding: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              top: height * 0.02,
                              bottom: height * 0.02),
                          decoration: kdecorationForContainerActiveItem,
                          child: Column(
                            children: [
                              Text(
                                "CUSTOMER_PROMOTION.PROMOTION_MISSION".tr(),
                                style: kfont26_400(),
                              ),
                              sectionBufferHeight(bufferSection: height * 0.01),
                              Stack(
                                children: [
                                  Container(
                                    width: width * 0.8,
                                    height: height * 0.03,
                                    decoration: kdecorationContainerBrownColor,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: constraints
                                                                .minWidth *
                                                            0.005,
                                                        right: constraints
                                                                .minWidth *
                                                            0.005),
                                                    width:
                                                        constraints.maxWidth *
                                                            0.8,
                                                    height: height * 0.026,
                                                    decoration:
                                                        kdecorationForContainerYellowProgressBar,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      top: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Center(
                                        child: Text(
                                          "80%",
                                          style: kfontH2InterBlackColor(),
                                        ),
                                      ))
                                ],
                              ),
                              Text(
                                "รีเซ้ตในอีก 3 วัน",
                                style: kfontH2InterBlackColor(),
                              ),
                              sectionBufferHeight(
                                bufferSection: height * 0.01,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  //TODO CLAIM CODE
                                  bool isNotEmpty =
                                      await _vm.onUserClaimingPromotionCode();
                                  setState(() {
                                    _vm.getApiPromotion();

                                    if (isNotEmpty) {
                                      Utility.toastMessage(
                                        "ERROR_MESSAGE.CLAIM_CODE_SUCCESS".tr(),
                                      );
                                    } else {
                                      Utility.toastMessage(
                                          "ERROR_MESSAGE.CLAIM_CODE_FAIL".tr());
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.05,
                                    vertical: height * 0.01,
                                  ),
                                  decoration: kdecorationButtonDisableContainer,
                                  child: Text(
                                    "CUSTOMER_PROMOTION.CLAIM_CODE".tr(),
                                    style: kfont22w_400black(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: _vm.promotionListModel,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: width,
                                  height: height,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "ERROR_MESSAGE.ERROR_LOADING_FAIL".tr(),
                                  style: kfont32_400(),
                                ),
                              );
                            } else if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                !snapshot.hasError) {
                              List<Promotion> promotionClaiming =
                                  _vm.filteredPromotions;

                              late List<Promotion> displayList;

                              if (filterTimelineMap["Most Recent"]!) {
                                displayList = sortAndLimitDisplayList(
                                    promotionClaiming, true);
                              } else if (filterTimelineMap["Oldest"]!) {
                                displayList = sortAndLimitDisplayList(
                                    promotionClaiming, false);
                              }

                              return _claimingCodeSection(
                                  width, height, displayList);
                            }
                            return Container();
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Container _claimingCodeSection(
      double width, double height, List<Promotion> promotionClaiming) {
    return Container(
      padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          top: height * 0.02,
          bottom: height * 0.02),
      decoration: kdecorationForContainerActiveItem,
      child: Column(
        children: [
          Text(
            "CUSTOMER_PROMOTION.CODE_CLAIMED".tr(),
            style: kfont26_400(),
          ),
          sectionBufferHeight(bufferSection: height * 0.01),
          _searchBar(),
          sectionBufferHeight(bufferSection: height * 0.01),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  promotionClaiming.isNotEmpty
                      ? "จำนวน ${promotionClaiming.length.toString()} โค้ด "
                      : "จำนวน 0 โค้ด",
                  style: kfontH2InterBoldBlackColor(),
                  textAlign: TextAlign.start,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {});
                },
                child: Container(),
              ),
            ],
          ),
          sectionBufferHeight(
            bufferSection: height * 0.01,
          ),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: promotionClaiming.isEmpty ? 1 : promotionClaiming.length,
            itemBuilder: (context, index) {
              bool? isExpired;
              if (promotionClaiming.isNotEmpty &&
                  promotionClaiming[index].dateExpired != null) {
                String dateExpiredString =
                    promotionClaiming[index].dateExpired!;
                isExpired = Helper.compareDateTimeNow(dateExpiredString);
              } else {
                isExpired = true;
              }
              if (promotionClaiming.isEmpty) {
                Container();
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.01,
                  ),
                  margin: EdgeInsets.only(
                    top: height * 0.01,
                  ),
                  decoration: kdecorationForContainerApplication,
                  foregroundDecoration: isExpired
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.6),
                        )
                      : const BoxDecoration(
                          color: Colors
                              .transparent, // or any default value for not expired
                        ), // Null if not expired
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //TODO SHOP NAME
                                promotionClaiming[index].name!,
                                style: kfont26_400(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                              ),
                              Text(
                                "${promotionClaiming[index].codeDetail}!",
                                style: kfontH2InterBlackColor(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${"CUSTOMER_PROMOTION.EXPIRED_DATE".tr()} ${Helper.getDisplayTimeDate(promotionClaiming[index].dateExpired!)}",
                                  style: kfontH2InterBoldBlackColor(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (isExpired != null && !isExpired) {
                                    //TODO NAVIGATE TO QRCODE AND ACTIVATE THE CODE
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerBarcodeView(
                                          codeString: promotionClaiming[index]
                                              .codeString!,
                                          codeDetail: promotionClaiming[index]
                                              .codeDetail!,
                                          dateExpired: promotionClaiming[index]
                                              .dateExpired!,
                                          codeName:
                                              promotionClaiming[index].name!,
                                        ),
                                      ),
                                    );
                                  } else {
                                    print("Code Expired");
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01,
                                      horizontal: width * 0.05),
                                  decoration:
                                      kdecorationForContainerAcceptButton,
                                  child: Text(
                                    "BUTTON.USE_CODE".tr(),
                                    style: kfontH1InterBoldBlackColor(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return null;
            },
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      alignment: Alignment.centerLeft,
      // margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: TextFormField(
          onFieldSubmitted: (value) {
            //Go to search Result View
            setState(() {
              _vm.onCustomerSearchShopByName(
                  textFilterShopName: searchController.text);
            });
          },
          focusNode: searchFocusNode,
          textInputAction: TextInputAction.go,
          controller: searchController,
          style: kfontH1Inter_400BlackColor(),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "CUSTOMER_PROMOTION.HINT_SEARCH_CODE".tr(),
            suffixIcon: IconButton(
              onPressed: () {
                //Filter Text ShopName
                setState(() {
                  _vm.onCustomerSearchShopByName(
                      textFilterShopName: searchController.text);
                });
              },
              icon: const Icon(Icons.search),
              iconSize: 30,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  List<Promotion> sortAndLimitDisplayList(
      List<Promotion> inputList, bool descendingOrder) {
    DateTime currentDateTime = DateTime.now();

    List<Promotion> sortedList = List.from(inputList);

    if (descendingOrder) {
      // Sort in descending order based on timestamp
      sortedList.sort((a, b) => DateTime.parse(b.dateExpired!)
          .compareTo(DateTime.parse(a.dateExpired!)));
    } else {
      // Sort in ascending order based on timestamp
      sortedList.sort((a, b) => DateTime.parse(a.dateExpired!)
          .compareTo(DateTime.parse(b.dateExpired!)));
    }

    // Remove expired promotions
    sortedList.removeWhere((promotion) =>
        DateTime.parse(promotion.dateExpired!).isBefore(currentDateTime));

    return sortedList;
  }
}
