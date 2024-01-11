import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/my_component/shop_register_statusbar.dart';
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
              _selectedImage != null
                  ? Container(
                      margin: EdgeInsets.all(16),
                      width: 250,
                      height: 150,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(_selectedImage!.path),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(16),
                      width: 250,
                      height: 150,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
              sectionBufferHeight(bufferSection: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: main1V4,
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
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: main1V4,
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
              sectionBufferHeight(bufferSection: 40),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                headingContainer(header: "MENU"),
                Container(
                  child: Text(
                    "ดูทั้งหมด",
                    style: kfontH3InterBlackColor(),
                  ),
                )
              ]),
              sectionBufferHeight(bufferSection: 5),
              Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: 2,
                    options: CarouselOptions(
                      // height: 0,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      scrollPhysics: BouncingScrollPhysics(),
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        margin: EdgeInsets.all(16),
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          color: sup1V5,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 16, left: 16, right: 5, bottom: 16),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: backGroundButton,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 16, left: 16, right: 5, bottom: 16),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(),
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
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
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
              Spacer(),
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
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          width: width / 4,
                          height: constraints.maxHeight * 0.07,
                          decoration: BoxDecoration(
                              color: backGroundButton,
                              border: Border.all(color: borderButton),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
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
                                      const ShopRegisterSecondView(),
                                ));
                            // Add more logic as needed
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          width: width / 1.7,
                          height: constraints.maxHeight * 0.07,
                          decoration: BoxDecoration(
                              color: colorAcceptButton,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Center(
                            child: Text(
                              "NEXTPAGE",
                              style: kfontH1InterBlackColor(),
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
      _selectedImage = File(returnedImage!.path);
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
