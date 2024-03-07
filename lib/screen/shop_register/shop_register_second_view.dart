import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_application/provider/customer-provider.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/screen/all_menu_shop.dart';
import 'package:coffee_application/viewmodel/register_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/screen/my_component/shop_register_statusbar.dart';
import 'package:coffee_application/screen/shop_register/shop_register_third_view.dart';
import 'package:coffee_application/screen/shop_text_field_form.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

class ShopRegisterSecondView extends StatefulWidget {
  const ShopRegisterSecondView({super.key});

  @override
  State<ShopRegisterSecondView> createState() => _ShopRegisterSecondViewState();
}

class _ShopRegisterSecondViewState extends State<ShopRegisterSecondView> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file;
  Uint8List webImage = Uint8List(10);

  late RegisterVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = RegisterVM(
      customerProvider: context.read<CustomerProvider>(),
      shopProvider: context.read<ShopProvider>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
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
              context.read<ShopProvider>().shop.coverImage != null
                  ? Container(
                      margin: const EdgeInsets.all(16),
                      width: width * 0.606,
                      height: height * 0.1639,
                      decoration: BoxDecoration(
                          color: backGroundButton,
                          borderRadius: BorderRadius.circular(20),
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            )
                          ]),
                      child: FittedBox(
                        clipBehavior: Clip.hardEdge,
                        fit: BoxFit.fill,
                        child: kIsWeb
                            ? Image.memory(webImage)
                            : Image.file(File(
                                context.read<ShopProvider>().shop.coverImage!)),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(16),
                      width: width * 0.606,
                      height: height * 0.1639,
                      decoration: BoxDecoration(
                          color: backGroundButton,
                          borderRadius: BorderRadius.circular(20)),
                    ),
              sectionBufferHeight(bufferSection: height * 0.0109),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      uploadImage().then((value) => {
                            if (value != null)
                              {
                                print("Hello world"),
                                context.read<ShopProvider>().coverImage =
                                    value.path
                              }
                          });
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
                      uploadImage().then((value) => {
                            if (value != null)
                              {context.read<ShopProvider>().coverImage = value}
                          });
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllMenuShopPage(
                                    shop: context.read<ShopProvider>().shop)))
                        .then((value) => setState(() {}));
                  },
                  child: Container(
                    child: Text(
                      "ดูทั้งหมด",
                      style: kfontH3InterBlackColor(),
                    ),
                  ),
                )
              ]),
              sectionBufferHeight(bufferSection: height * 0.0054),
              Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: context.read<ShopProvider>().shop.menus == null
                        ? 1
                        : context.read<ShopProvider>().shop.menus.length,
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
                            context.read<ShopProvider>().shop.menus == null
                                ? _imageContainerTemp(height, width)
                                : _imageContainerToDisplay(
                                    height,
                                    width,
                                    context
                                        .read<ShopProvider>()
                                        .shop
                                        .menus[index]
                                        .image!),
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
                                    context
                                        .read<ShopProvider>()
                                        .shop
                                        .menus[index]
                                        .name!,
                                    style: kfontH2InterBlackColor(),
                                  ),
                                  Text(
                                    context
                                        .read<ShopProvider>()
                                        .shop
                                        .menus[index]
                                        .category!,
                                    style: kfontH2InterBlackColorHalfOpacity(),
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
                                "${context.read<ShopProvider>().shop.menus[index].price!.toString()} ฿",
                                style: kfontH2InterBlackColor(),
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
                          setState(() {
                            Navigator.push(
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
                          if (context.read<ShopProvider>().shop.coverImage ==
                              null) {
                            return Utility.flushBarErrorMessage(
                                message:
                                    "ERROR_MESSAGE.PLEASE_SELECT_IMAGE".tr(),
                                context: context);
                          }
                          if (context.read<ShopProvider>().shop.menus.isEmpty) {
                            return Utility.flushBarErrorMessage(
                                message:
                                    "ERROR_MESSAGE.PLEASE_SELECT_MENU".tr(),
                                context: context);
                          }

                          setState(() {
                            Navigator.push(
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
                              color: kcolorAcceptButton,
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          child: Text(
                            " < ย้อนกลับ",
                            style: kfontH2InterBlackColor(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ]),
          );
        }),
      ),
    ));
  }

  Container _imageContainerTemp(double height, double width) {
    return Container(
      margin: EdgeInsets.only(
          top: height * 0.0174,
          left: width * 0.0388,
          right: width * 0.0121,
          bottom: height * 0.0174),
      width: width * 0.2427,
      height: height * 0.109,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(americanoImagePath)),
          color: backGroundButton,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  Container _imageContainerToDisplay(
      double height, double width, String imageToDisplay) {
    return Container(
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: kIsWeb
          ? FutureBuilder(
              future: (_xfileToUnit8(XFile(imageToDisplay))),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("ERROR_MESSAGE.ERROR_LOADING_FAIL").tr();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return Image.memory(
                    snapshot.data!,
                  );
                }
                return Container();
              },
            )
          : Image.file(File(XFile(imageToDisplay).path)),
    );
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

  Text headingContainer({required String header}) {
    return Text(
      header,
      style: kfontH3InterBlackColor(),
      textAlign: TextAlign.left,
    );
  }
}
