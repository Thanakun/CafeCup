import 'package:coffee_application/screen/my_component/buttom_navigationbar_shop.dart';
import 'package:coffee_application/screen/scan_view.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                  width: width,
                  height: height,
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.07281, vertical: height * 0.0163),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "PROMOTION.CODE_AVALIABLE".tr(),
                                style: kfont32_400(),
                              ),
                            ),
                            sectionBufferHeight(bufferSection: 20),
                            Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.2,
                                  right: width * 0.2,
                                  top: height * 0.025,
                                  bottom: height * 0.025),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: backGroundButton),
                              child: Text(
                                "ส่วนลด 5 บาท",
                                style: kfont22w_400black(),
                              ),
                            ),
                            sectionBufferHeight(bufferSection: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: backGroundButton
                                ),
                                child: Text(
                                  "วันหมดอายุ : 28/11/2023 \nจำนวนโค้ดที่เหลืออยู่: 23 โค้ด",
                                  style: kfont22w_400black(),
                                ),
                              ),
                            ),
                            // sectionBufferHeight(bufferSection: 20),
                          ],
                        ),
                      ),
                      sectionBufferHeight(bufferSection: height * 0.025),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScannerCodePage()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.0194),
                          width: width / 1.7,
                          height: constraints.maxHeight * 0.07,
                          decoration: BoxDecoration(
                              color: kcolorAcceptButton,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
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
                              sectionBufferHeight(bufferSection: height * 0.02),
                              Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.05, right: width * 0.05),
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
                              // sectionBufferHeight(bufferSection: height * 0.01),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "#AVSDAD",
                                    style: kfont22w_400black(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Spacer(),
                                  Text(
                                    "25/11/23 14:08:01",
                                    style: kfont22w_400black(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "#FDASDF",
                                    style: kfont22w_400black(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Spacer(),
                                  Text(
                                    "25/11/23 14:06:25",
                                    style: kfont22w_400black(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "#AFSASAS",
                                    overflow: TextOverflow.ellipsis,
                                    style: kfont22w_400black(),
                                  ),
                                  Spacer(),
                                  Text(
                                    "25/11/23 13:55:44",
                                    overflow: TextOverflow.ellipsis,
                                    style: kfont22w_400black(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
