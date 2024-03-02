import 'package:coffee_application/model/request/promotion_create_request.dart';
import 'package:coffee_application/model/response/promotion_shop.dart';
import 'package:coffee_application/screen/my_component/buttom_navigationbar_shop.dart';
import 'package:coffee_application/screen/scan_view.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/shop_promotion_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  late final ShopPromotionVM _vm;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController codeDetail = TextEditingController();
  TextEditingController expiredLength = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vm = ShopPromotionVM();
    _vm.getPromotionByShopID();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ShopBottomNavigationBar(pageName: "PROMOTION"),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(255, 245, 233, 1),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<PromotionShop>(
            future: _vm.promotionList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(),
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    PromotionShop promotionList = snapshot.data!;
                    return Container(
                        width: width,
                        height: height,
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.07281,
                            vertical: height * 0.0163),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.1,
                                  right: width * 0.1,
                                  top: height * 0.025,
                                  bottom: height * 0.025),
                              decoration: BoxDecoration(
                                color: selectButtonColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: promotionList.available!.isNotEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "PROMOTION.CODE_AVALIABLE".tr(),
                                          style: kfont32_400(),
                                        ),
                                        sectionBufferHeight(bufferSection: 20),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: width * 0.1,
                                              right: width * 0.1,
                                              top: height * 0.025,
                                              bottom: height * 0.025),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: backGroundButton),
                                          child: Text(
                                            promotionList
                                                    .available![0].codeDetail ??
                                                "",
                                            style: kfont22w_400black(),
                                          ),
                                        ),
                                        sectionBufferHeight(bufferSection: 20),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // color: backGroundButton
                                            ),
                                            child: Text(
                                              "วันหมดอายุ : ${Helper.getDisplayTimeDate(promotionList.available![0].dateExpired!)} \n มีจำนวนโค้ดอยู่ ${promotionList.available!.length} รหัส",
                                              style: kfont22w_400black(),
                                            ),
                                          ),
                                        ),
                                        // sectionBufferHeight(bufferSection: 20),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "PROMOTION.CODE_AVALIABLE_EMPTY".tr(),
                                          style: kfont32_400(),
                                        ),
                                        sectionBufferHeight(bufferSection: 20),
                                        GestureDetector(
                                          onTap: () async {
                                            await _showDialog(context).then(
                                                (value) => setState(() {}));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: width * 0.1,
                                                right: width * 0.1,
                                                top: height * 0.025,
                                                bottom: height * 0.025),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: backGroundButton),
                                            child: Text(
                                              "PROMOTION.CREATE_CODE_PROMOTION"
                                                  .tr(),
                                              style: kfont22w_400black(),
                                            ),
                                          ),
                                        ),
                                        sectionBufferHeight(bufferSection: 20),
                                        // Align(
                                        //   alignment: Alignment.centerLeft,
                                        //   child: Container(
                                        //     decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(10),
                                        //       // color: backGroundButton
                                        //     ),
                                        //     child: Text(
                                        //       "วันหมดอายุ : 28/11/2023 \nจำนวนโค้ดที่เหลืออยู่: 23 โค้ด",
                                        //       style: kfont22w_400black(),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                            ),
                            sectionBufferHeight(bufferSection: height * 0.025),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ScannerCodePage()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.0194),
                                width: width / 1.7,
                                height: constraints.maxHeight * 0.07,
                                decoration: BoxDecoration(
                                    color: kcolorAcceptButton,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: Center(
                                  child: Text(
                                    "PROMOTION.SCAN_CODE".tr(),
                                    style: kfontH0InterBlackColor(),
                                  ),
                                ),
                              ),
                            ),
                            sectionBufferHeight(bufferSection: height * 0.025),
                            Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.1,
                                  right: width * 0.1,
                                  top: height * 0.025,
                                  bottom: height * 0.025),
                              decoration: BoxDecoration(
                                color: selectButtonColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "PROMOTION.HISTORY_USED".tr(),
                                      style: kfont26_400(),
                                    ),
                                    sectionBufferHeight(
                                        bufferSection: height * 0.02),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: width * 0.05,
                                          right: width * 0.05),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Code",
                                            style: kfontH1InterBoldBlackColor(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Spacer(),
                                          Text(
                                            "วันเวลา",
                                            overflow: TextOverflow.ellipsis,
                                            style: kfontH1InterBoldBlackColor(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (promotionList.activated!.isNotEmpty)
                                      ...promotionList.activated!.map(
                                        (e) => _historyActivateCode(
                                          width: width,
                                          height: height,
                                          activateCode: e,
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ));
                  },
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text(
                  "ERROR_MESSAGE.ERROR_LOADING_FAIL".tr(),
                  style: kfontH1InterBoldBlackColor(),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Row _historyActivateCode({
    required double width,
    required double height,
    required Activated activateCode,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: width * 0.3,
          child: Text(
            activateCode.codeDetail ?? "",
            style: kfont22w_400black(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Spacer(),
        Text(
          Helper.getDisplayTimeDateTime(activateCode.usedTimestamp!),
          style: kfont22w_400black(),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Future<void> _showDialog(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backGroundApplication,
        surfaceTintColor: Colors.transparent,
        content: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Form(
              key: _formKey,
              child: StatefulBuilder(
                  builder: (context, StateSetter setStateDialog) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      maxLines: 2,
                      style: kfontH2InterBlackColor(),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          errorStyle: kfont22_400ErrorStyle(),
                          filled: true,
                          fillColor: Colors.white,
                          constraints: const BoxConstraints(minHeight: 100),
                          labelText: "PROMOTION_VALIDATE.LABEL.CODEDETAIL".tr(),
                          labelStyle: kfontH1InterBlackColorHalfOpacity(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintStyle: kfontH2InterBlackColor()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PROMOTION_VALIDATE.VALIDATOR_FIELD.CODEDETAIL'
                              .tr();
                        }

                        return null;
                      },
                      controller: codeDetail,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      style: kfontH2InterBlackColor(),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          errorStyle: kfont22_400ErrorStyle(),
                          filled: true,
                          fillColor: Colors.white,
                          constraints: const BoxConstraints(minHeight: 100),
                          labelText:
                              "PROMOTION_VALIDATE.LABEL.EXPIREDLENGTH".tr(),
                          labelStyle: kfontH1InterBlackColorHalfOpacity(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintStyle: kfontH2InterBlackColor()),
                      validator: Helper.validateDateLimitCode,
                      controller: expiredLength,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      style: kfontH2InterBlackColor(),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          errorStyle: kfont22_400ErrorStyle(),
                          filled: true,
                          fillColor: Colors.white,
                          constraints: const BoxConstraints(minHeight: 100),
                          labelText: "PROMOTION_VALIDATE.LABEL.AMOUNT".tr(),
                          labelStyle: kfontH1InterBlackColorHalfOpacity(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintStyle: kfontH2InterBlackColor()),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PROMOTION_VALIDATE.VALIDATOR_FIELD.AMOUNT'
                              .tr();
                        }
                        return null;
                      },
                      controller: amount,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              decoration: kdecorationForContainerButton,
                              child: Center(
                                child: Text(
                                  "BUTTON.BACK".tr(),
                                  style: kfontH1InterBoldBlackColor(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkResponse(
                            onTap: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  _vm
                                      .createPromotion(
                                          request: PromotionCreateRequestBody(
                                    codeDetail: codeDetail.text,
                                    expiredLength: expiredLength.text == ""
                                        ? 0
                                        : int.parse(expiredLength.text),
                                    amount: amount.text == ""
                                        ? 0
                                        : int.parse(amount.text),
                                  ))
                                      .then((value) {
                                    if (value) {
                                      Utility.toastMessage("SUCCESS");
                                      Navigator.pop(context);
                                      codeDetail.clear();
                                      expiredLength.clear();
                                      amount.clear();
                                      setState(() {});
                                    }
                                  });
                                }
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              decoration: kdecorationForContainerAcceptButton,
                              child: Center(
                                child: Text(
                                  "BUTTON.BUTTON_SAVE".tr(),
                                  style: kfontH1InterBoldBlackColor(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
