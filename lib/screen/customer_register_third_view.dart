import 'package:coffee_application/screen/customer_register_view.dart';
import 'package:coffee_application/screen/customer_shop_view.dart';
import 'package:coffee_application/screen/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../utility/my_constant.dart';

class CustomerRegisterThird extends StatefulWidget {
  const CustomerRegisterThird({super.key});

  @override
  State<CustomerRegisterThird> createState() => _CustomerRegisterThirdState();
}

class _CustomerRegisterThirdState extends State<CustomerRegisterThird> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(255, 245, 233, 1),
        body: Container(
          decoration: BoxDecoration(
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
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: width * 0.05,
                            right: width * 0.05,
                            top: height * 0.025,
                            bottom: height * 0.025),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_outline_outlined,
                              size: height * 0.2,
                              color: kcolorAcceptButton,
                            ),
                            Container(
                              child: Text(
                                "CUSTOMER_REGISTER.REGISTER_INFORMATION_COMPLETE"
                                    .tr(),
                                style: kfont32_400(),
                              ),
                            ),
                            Container(
                              child: Text(
                                "ยินดีต้อนรับเข้าสู่แอพของเรา ท่านสามารถเริ่มต้นใช้บริการของแอพเราได้ ทันทีและสามารถกลับมาแก้ไขข้อมูลส่วน ตัวในภายหลังได้",
                                style: kfontH1InterBlackColorHalfOpacity(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.greenAccent,
                          onTap: () {
                            //TODO Shop First
                            // if (nameShop.text.isEmpty ||
                            //     descriptionShop.text.isEmpty ||
                            //     selectedProvince == null ||
                            //     selectedDistrict == null ||
                            //     selectedSubDistrict == null ||
                            //     addressDetail.text.isEmpty) {
                            //   // Display an error message or perform some action for invalid input
                            //   Utility.flushBarErrorMessage(
                            //       message: "Please insert data information",
                            //       context: context);
                            //   return;
                            // }

                            setState(() {
                              Navigator.pushReplacement(
                                  (context),
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomerRegister(),
                                  ));
                              // Add more logic as needed
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            width: width / 4,
                            height: constraints.maxHeight * 0.07,
                            decoration: BoxDecoration(
                                color: backGroundButton,
                                border: Border.all(color: brownBorderButton),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Center(
                              child: Text(
                                "BUTTON.RESET_SETTINGS".tr(),
                                style: kfontH2InterBlackColor(),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPage()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.0194),
                            width: width / 1.7,
                            height: constraints.maxHeight * 0.07,
                            decoration: BoxDecoration(
                                color: kcolorAcceptButton,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Center(
                              child: Text(
                                "BUTTON.BACK_TO_LOGIN_PAGE".tr(),
                                style: kfontH1InterBoldBlackColor(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
