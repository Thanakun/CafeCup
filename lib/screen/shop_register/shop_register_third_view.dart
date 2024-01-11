import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/my_component/shop_register_statusbar.dart';
import 'package:flutter_application_1/utility/my_constant.dart';

class ShopRegisterThirdView extends StatefulWidget {
  const ShopRegisterThirdView({super.key});

  @override
  State<ShopRegisterThirdView> createState() => _ShopRegisterThirdViewState();
}

class _ShopRegisterThirdViewState extends State<ShopRegisterThirdView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(255, 245, 233, 1),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: width,
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const ShopStatusBarRegister(
                shopIndicatorRegistationState: 3,
              ),
              sectionBufferHeight(bufferSection: 20),
              Container(
                child: Center(
                  child: Text(
                    "Overview Information",
                    style: kfontH1InterBlackColor(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              sectionBufferHeight(bufferSection: 20),
              headingContainer(header: "Cafe Thumbnail"),
              Spacer(),
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
                    // Navigator.pushReplacement(
                    //     (context),
                    //     MaterialPageRoute(
                    //       builder: (context) => (),
                    //     ),);
                    // Add more logic as needed
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  width: double.infinity,
                  height: constraints.maxHeight * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Center(
                    child: Text(
                      "NEXT PAGE",
                      style: kfontH1InterBlackColor(),
                    ),
                  ),
                ),
              )
            ]),
          );
        }),
      ),
    ));
  }

  Text headingContainer({required String header}) {
    return Text(
      header,
      style: kfontH3InterBlackColor(),
      textAlign: TextAlign.left,
    );
  }
}
