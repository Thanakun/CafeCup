import 'dart:io';
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
                      decoration: BoxDecoration(),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Add",
                                style: kfontH2InterBlackColor(),
                              ),
                              const WidgetSpan(child: Icon(Icons.image_sharp))
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
                      decoration: BoxDecoration(),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Add",
                                style: kfontH2InterBlackColor(),
                              ),
                              const WidgetSpan(
                                  child: Icon(Icons.camera_alt_rounded))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
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
                          builder: (context) => const ShopRegisterSecondView(),
                        ));
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
