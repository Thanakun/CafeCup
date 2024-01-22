import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/my_component/shop_register_statusbar.dart';
import 'package:flutter_application_1/screen/shop_register/shop_register_third_view.dart';
import 'package:flutter_application_1/screen/shop_text_field_form.dart';
import 'package:flutter_application_1/utility/my_constant.dart';
import 'package:image_picker/image_picker.dart';

class ShopRegisterSecondView extends StatefulWidget {
  const ShopRegisterSecondView({super.key});

  @override
  State<ShopRegisterSecondView> createState() => _ShopRegisterSecondViewState();
}

class _ShopRegisterSecondViewState extends State<ShopRegisterSecondView> {
  final ImagePicker _imagePicker = ImagePicker();
  // XFile? _selectedImage;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      // ),
      resizeToAvoidBottomInset: false,
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
                shopIndicatorRegistationState: 2,
              ),
              sectionBufferHeight(bufferSection: height * 0.0218),
              Container(
                child: Center(
                  child: Text(
                    "Overview Information",
                    style: kfontH1InterBoldBlackColor(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              sectionBufferHeight(bufferSection: height * 0.0218),
              headingContainer(header: "Cafe Thumbnail"),
              _selectedImage != null
                  ? Container(
                      margin: const EdgeInsets.all(16),
                      width: width * 0.606,
                      height: height * 0.1639,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(_selectedImage!.path),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(16),
                      width: width * 0.606,
                      height: height * 0.1639,
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
              sectionBufferHeight(bufferSection: height * 0.0109),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: fontMenuNameColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "camera ",
                                style: kfontH2InterWhiteColor(),
                              ),
                              const WidgetSpan(
                                  child: Icon(
                                Icons.image_sharp,
                                color: Colors.white,
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: fontMenuNameColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "gallery ",
                                style: kfontH2InterWhiteColor(),
                              ),
                              const WidgetSpan(
                                  child: Icon(Icons.camera_alt_outlined,
                                      color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sectionBufferHeight(bufferSection: height * 0.0437),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                headingContainer(header: "MENU"),
                Container(
                  child: Text(
                    "ดูทั้งหมด",
                    style: kfontH3InterBlackColor(),
                  ),
                )
              ]),
              sectionBufferHeight(bufferSection: height * 0.0054),
              Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: 2,
                    options: CarouselOptions(
                      // height: 0,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        margin: const EdgeInsets.all(16),
                        width: double.infinity,
                        height: height * 0.08196,
                        decoration: BoxDecoration(
                          color: backgroundActiveButton,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.0174,
                                  left: width * 0.0388,
                                  right: width * 0.0121,
                                  bottom: height * 0.0174),
                              width: width * 0.2427,
                              height: height * 0.109,
                              decoration: BoxDecoration(
                                  color: backGroundButton,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.0174,
                                  left: width * 0.0388,
                                  right: width * 0.0121,
                                  bottom: height * 0.0174),
                              width: width * 0.2427,
                              height: height * 0.109,
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "อเมริกาโน่",
                                    style: kfontH3InterBlackColor(),
                                  ),
                                  Text(
                                    "กาแฟ",
                                    style: kfontH3InterBlackColorHalfOpacity(),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              margin: EdgeInsets.only(
                                  left: width * 0.0388, right: width * 0.0388),
                              child: Text(
                                "50 ฿",
                                style: kfontH3InterBlackColor(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
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
                                      const ShopRegisterSecondView(),
                                ));
                            // Add more logic as needed
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.0194),
                          width: width / 4,
                          height: constraints.maxHeight * 0.07,
                          decoration: BoxDecoration(
                              color: backGroundButton,
                              border: Border.all(color: brownBorderButton),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0))),
                          child: Center(
                            child: Text(
                              "SKIP",
                              style: kfontH2InterBlackColor(),
                            ),
                          ),
                        ),
                      ),
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
                                      const ShopRegisterThirdView(),
                                ));
                            // Add more logic as needed
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.0194),
                          width: width / 1.7,
                          height: constraints.maxHeight * 0.07,
                          decoration: const BoxDecoration(
                              color: colorAcceptButton,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Center(
                            child: Text(
                              "NEXTPAGE",
                              style: kfontH1InterBoldBlackColor(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]),
          );
        }),
      ),
    ));
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (returnedImage != null) _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await _imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

  Text headingContainer({required String header}) {
    return Text(
      header,
      style: kfontH3InterBlackColor(),
      textAlign: TextAlign.left,
    );
  }
}
