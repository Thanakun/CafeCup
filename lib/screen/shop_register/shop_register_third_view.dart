import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_application/data/widget/add_editing_image.dart';
import 'package:coffee_application/provider/customer-provider.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/viewmodel/register_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/data/widget/time_picker.dart';
import 'package:coffee_application/screen/shop_register/shop_register_forth_view.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:coffee_application/screen/my_component/shop_register_statusbar.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ShopRegisterThirdView extends StatefulWidget {
  const ShopRegisterThirdView({super.key});

  @override
  State<ShopRegisterThirdView> createState() => _ShopRegisterThirdViewState();
}

class _ShopRegisterThirdViewState extends State<ShopRegisterThirdView> {
  final int _totalImagesOfShop = 0;
  final int _maximumImagesAddingPossible = 3;

  ImagePicker _imagePicker = ImagePicker();
  List<XFile>? _shopImagesFileList = [];

  int _current = 0;
  final CarouselController _controller = CarouselController();

  late RegisterVM _vm;

  Map<int, String> dateIndexMap = {
    0: "จ",
    1: "อ",
    2: "พ",
    3: "พฤ",
    4: "ศ",
    5: "ส",
    6: "อา"
  };

  Map<String, bool> selectImageType = {
    "Shop": true,
    "Food": false,
    "Menu": false,
  };

  List<bool> isSelectDate = [false, false, false, false, false, false, false];

  TextEditingController timeController = TextEditingController();

  int openHour = 0;
  int openMinute = 0;
  // String openTimeFormat = "AM";

  int closeHour = 0;
  int closeMinute = 0;
  // String closeTimeFormat = "AM";

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
            margin: EdgeInsets.only(
                left: width * 0.07281,
                right: width * 0.07281,
                top: height * 0.0163),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShopStatusBarRegister(
                    shopIndicatorRegistationState: 3,
                  ),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  Container(
                    child: Center(
                      child: Text(
                        "บรรยากาศและเวลาเปิดปิด",
                        style: kfontH1InterBoldBlackColor(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  headingContainer(
                    header: "รูปภาพบรรยากาศในร้าน",
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: width * 0.07281,
                            top: height * 0.0109,
                            right: width * 0.07281,
                            bottom: height * 0.0109),
                        child: Row(children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectImageType["Shop"] = true;
                                selectImageType["Food"] = false;
                                selectImageType["Menu"] = false;
                                _current = 0;
                              });
                            },
                            child: AnimatedContainer(
                              padding: EdgeInsets.only(
                                  left: width * 0.03,
                                  right: width * 0.03,
                                  top: height * 0.01,
                                  bottom: height * 0.01),
                              duration: const Duration(milliseconds: 200),
                              decoration: selectImageType["Shop"] == true
                                  ? kdecorationForContainerActiveItem
                                  : kdecorationForContainerApplication,
                              child: Text(
                                "รูปร้าน",
                                style: selectImageType["Shop"] == true
                                    ? kfontH2InterBoldBlackColor()
                                    : kfontH2InterBlackColorHalfOpacity(),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectImageType["Food"] = true;
                                selectImageType["Shop"] = false;
                                selectImageType["Menu"] = false;
                                _current = 0;
                              });
                            },
                            child: AnimatedContainer(
                              padding: EdgeInsets.only(
                                  left: width * 0.03,
                                  right: width * 0.03,
                                  top: height * 0.01,
                                  bottom: height * 0.01),
                              duration: const Duration(milliseconds: 200),
                              decoration: selectImageType["Food"] == true
                                  ? kdecorationForContainerActiveItem
                                  : kdecorationForContainerApplication,
                              child: Text(
                                "อาหาร",
                                style: selectImageType["Food"] == true
                                    ? kfontH2InterBoldBlackColor()
                                    : kfontH2InterBlackColorHalfOpacity(),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectImageType["Menu"] = true;
                                selectImageType["Food"] = false;
                                selectImageType["Shop"] = false;
                                _current = 0;
                              });
                            },
                            child: AnimatedContainer(
                              padding: EdgeInsets.only(
                                  left: width * 0.03,
                                  right: width * 0.03,
                                  top: height * 0.01,
                                  bottom: height * 0.01),
                              duration: const Duration(milliseconds: 200),
                              decoration: selectImageType["Menu"] == true
                                  ? kdecorationForContainerActiveItem
                                  : kdecorationForContainerApplication,
                              child: Text(
                                "เมนู",
                                style: selectImageType["Menu"] == true
                                    ? kfontH2InterBoldBlackColor()
                                    : kfontH2InterBlackColorHalfOpacity(),
                              ),
                            ),
                          ),
                          const Spacer(),
                          getListImagesFromSelect().isNotEmpty
                              ? GestureDetector(
                                  child: Text(
                                    "แก้ไข / เพิ่ม",
                                    style: kfontH3InterBlackColorHalfOpacity(),
                                  ),
                                  onTap: () {
                                    //TODO edit and add image
                                    // selectImage().then((value) {
                                    //   if (selectImageType["Shop"] == true) {
                                    //     context
                                    //         .read<ShopProvider>()
                                    //         .addShopImageAll(
                                    //             _shopImagesFileList!);
                                    //   } else if (selectImageType["Food"] ==
                                    //       true) {
                                    //     context
                                    //         .read<ShopProvider>()
                                    //         .addFoodImageAll(
                                    //             _shopImagesFileList!);
                                    //   } else if (selectImageType["Menu"] ==
                                    //       true) {
                                    //     context
                                    //         .read<ShopProvider>()
                                    //         .addMenuImageAll(
                                    //             _shopImagesFileList!);
                                    //   }
                                    // });

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddEditingImagesList(
                                          listOfImagesOne: context
                                              .read<ShopProvider>()
                                              .shop
                                              .shopImage,
                                          listOfImagesTwo: context
                                              .read<ShopProvider>()
                                              .shop
                                              .menuImages,
                                          listOfImagesThree: context
                                              .read<ShopProvider>()
                                              .shop
                                              .foodImages,
                                          listOfImagesFour: context
                                              .read<ShopProvider>()
                                              .shop
                                              .otherImages,
                                          callBackFunction:
                                              callbackSetStateFunction,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                        ]),
                      ),
                    ],
                  ),
                  CarouselSlider.builder(
                    itemCount: getListImagesFromSelect().isNotEmpty
                        ? getListImagesFromSelect().length
                        : 1,
                    options: CarouselOptions(
                        // height: 0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.7,
                        enableInfiniteScroll: false,
                        scrollPhysics: const BouncingScrollPhysics(),
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    itemBuilder: (context, index, realIndex) {
                      return getListImagesFromSelect().isEmpty
                          ? GestureDetector(
                              onTap: () {
                                selectImage().then((value) {
                                  List<String> _allImagePath = [];
                                  _shopImagesFileList!.forEach((element) {
                                    _allImagePath.add(element.path);
                                  });
                                  if (selectImageType["Shop"] == true) {
                                    context
                                        .read<ShopProvider>()
                                        .addShopImageAll(_allImagePath);
                                  } else if (selectImageType["Food"] == true) {
                                    context
                                        .read<ShopProvider>()
                                        .addFoodImageAll(_allImagePath);
                                  } else if (selectImageType["Menu"] == true) {
                                    context
                                        .read<ShopProvider>()
                                        .addMenuImageAll(_allImagePath);
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                width: double.infinity,
                                height: height * 0.109,
                                decoration: BoxDecoration(
                                  color: backgroundActiveButton,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: kfontH1InterBoldBlackColor(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(16),
                              width: double.infinity,
                              height: height * 0.109,
                              decoration: BoxDecoration(
                                color: backgroundActiveButton,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Image.file(File(
                                    getListImagesFromSelect()[index].path)),
                              ),
                            );
                    },
                  ),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  headingContainer(header: "วันและเวลาของร้าน"),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  _pickdateOpen(width, height),
                  sectionBufferHeight(bufferSection: height * 0.0174),
                  _pickdateOpenSecond(width, height),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  headingContainer(header: "เลือกเวลาเปิด-ปิด"),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  timePickerWidget(title: "OPEN TIME"),
                  _pickTimeOpen(height, context, width),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  timePickerWidget(title: "CLOSE TIME"),
                  _pickTimeClose(height, context, width),
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
                                          const ShopRegisterThirdView(),
                                    ));
                                // Add more logic as needed
                              });
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                            child: GestureDetector(
                              onTap: () {
                                if ((openHour == 0 && openMinute == 0) ||
                                    (closeHour == 0 && closeMinute == 0) ||
                                    !isSelectDate.contains(true)) {
                                  return Utility.flushBarErrorMessage(
                                      message:
                                          "ERROR_MESSAGE.PLEASE_SELECT_DATE"
                                              .tr(),
                                      context: context);
                                }

                                _vm.shopSignUpThirdPage(
                                  dateOpen: isSelectDate,
                                  openTime:
                                      conCatTimeFormat(openHour, openMinute),
                                  closeTime:
                                      conCatTimeFormat(closeHour, closeMinute),
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ShopRegisterForthView()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.0194),
                                width: width / 1.7,
                                height: constraints.maxHeight * 0.07,
                                decoration: const BoxDecoration(
                                    color: kcolorAcceptButton,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: Center(
                                  child: Text(
                                    "NEXTPAGE",
                                    style: kfontH1InterBoldBlackColor(),
                                  ),
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
                          const Spacer(),
                          Container(
                            child: Text(
                              "ถัดไป >",
                              style: kfontH2InterBlackColor(),
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

  Container _pickTimeClose(double height, BuildContext context, double width) {
    return Container(
      height: height * 0.0546,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.white),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return timePicker(
                  width: width,
                  height: height,
                  timeHour: closeHour,
                  timeMinute: closeMinute,
                  // timeFormat: closeTimeFormat,
                  onHourChanged: (value) {
                    setState(() {
                      closeHour = value;
                    });
                  },
                  onMinuteChanged: (value) {
                    setState(() {
                      closeMinute = value;
                    });
                  },
                  onFormatChanged: (value) {
                    setState(() {
                      // closeTimeFormat = value;
                    });
                  },
                );
              },
            );
          });
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: width * 0.0339),
              child: Text(
                "${closeHour.toString().padLeft(2, '0')}:${closeMinute.toString().padLeft(2, '0')} ",
                style: kfontH1InterBoldBlackColor(),
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(right: width * 0.024),
              child: Icon(Icons.calendar_view_day_outlined,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }

  Container _pickTimeOpen(double height, BuildContext context, double width) {
    return Container(
      height: height * 0.0546,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.white),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return timePicker(
                  width: width,
                  height: height,
                  timeHour: openHour,
                  timeMinute: openMinute,
                  // timeFormat: openTimeFormat,
                  onHourChanged: (value) {
                    setState(() {
                      openHour = value;
                    });
                  },
                  onMinuteChanged: (value) {
                    setState(() {
                      openMinute = value;
                    });
                  },
                  onFormatChanged: (value) {
                    setState(() {
                      // openTimeFormat = value;
                    });
                  },
                );
              },
            );
          });
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: width * 0.0339),
              child: Text(
                "${openHour.toString().padLeft(2, '0')}:${openMinute.toString().padLeft(2, '0')} ",
                style: kfontH1InterBoldBlackColor(),
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(right: width * 0.024),
              child: Icon(Icons.calendar_view_day_outlined,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }

  Row _pickdateOpenSecond(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 5; i < 7; i++)
          dateOpenSelectionButton(
            width: width,
            height: height,
            dateIndex: i,
          ),
      ],
    );
  }

  Row _pickdateOpen(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < 5; i++)
          dateOpenSelectionButton(
            width: width,
            height: height,
            dateIndex: i,
          ),
      ],
    );
  }

  String conCatTimeFormat(int hour, int minute) {
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');
    return "$formattedHour:$formattedMinute";
  }

  List<XFile> getListImagesFromSelect() {
    String item =
        selectImageType.entries.where((entry) => entry.value == true).first.key;
    List<XFile> listImages = [];
    if (item == "Shop") {
      for (String e in context.read<ShopProvider>().shop.shopImage) {
        listImages.add(XFile(e));
      }
    } else if (item == "Food") {
      for (String e in context.read<ShopProvider>().shop.foodImages) {
        listImages.add(XFile(e));
      }
    } else if (item == "Menu") {
      for (String e in context.read<ShopProvider>().shop.menuImages) {
        listImages.add(XFile(e));
      }
    }

    return listImages;
  }

  Row timePickerWidget({required String title}) {
    return Row(
      children: [
        Text(
          title,
          style: kfontH4InterBlackColor(),
        ),
        const Spacer(),
        Text(
          "HH:MM ",
          style: kfontH4InterBlackColor(),
        )
      ],
    );
  }

  AlertDialog timePicker({
    required height,
    required width,
    required int timeHour,
    required int timeMinute,
    // required String timeFormat,
    required Function(int) onHourChanged,
    required Function(int) onMinuteChanged,
    required Function(String) onFormatChanged,
  }) {
    return AlertDialog(
        // backgroundColor: Colors.transparent,
        content: StatefulBuilder(
      builder: (context, sBsetState) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.0485, vertical: height * 0.0109),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: timeHour,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: width * 0.194,
                        itemHeight: height * 0.0655,
                        onChanged: (value) {
                          onHourChanged(value);
                          sBsetState(() {
                            timeHour = value;
                          });
                        },
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                        selectedTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 30),
                        decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                color: Colors.white,
                              ),
                              bottom: BorderSide(color: Colors.white)),
                        ),
                      ),
                      NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: timeMinute,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: width * 0.194,
                        itemHeight: height * 0.0655,
                        onChanged: (value) {
                          onMinuteChanged(value);
                          sBsetState(() {
                            timeMinute = value;
                          });
                        },
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                        selectedTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 30),
                        decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                color: Colors.white,
                              ),
                              bottom: BorderSide(color: Colors.white)),
                        ),
                      ),
                      // Column(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         onFormatChanged("AM");
                      //         sBsetState(() {
                      //           timeFormat = "AM";
                      //         });
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 20, vertical: 10),
                      //         decoration: BoxDecoration(
                      //             color: timeFormat == "AM"
                      //                 ? Colors.grey.shade800
                      //                 : Colors.grey.shade700,
                      //             border: Border.all(
                      //               color: timeFormat == "AM"
                      //                   ? Colors.grey
                      //                   : Colors.grey.shade700,
                      //             )),
                      //         child: Text(
                      //           "AM",
                      //           style: kfontH0InterBlackColor(),
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       height: 15,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         onFormatChanged("PM");
                      //         sBsetState(() {
                      //           timeFormat = "PM";
                      //         });
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 20, vertical: 10),
                      //         decoration: BoxDecoration(
                      //           color: timeFormat == "PM"
                      //               ? Colors.grey.shade800
                      //               : Colors.grey.shade700,
                      //           border: Border.all(
                      //             color: timeFormat == "PM"
                      //                 ? Colors.grey
                      //                 : Colors.grey.shade700,
                      //           ),
                      //         ),
                      //         child: Text(
                      //           "PM",
                      //           style: kfontH0InterBlackColor(),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                )
              ])
            ]);
      },
    ));
  }

  GestureDetector dateOpenSelectionButton(
      {required int dateIndex, required width, required height}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelectDate[dateIndex] = !isSelectDate[dateIndex];
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: width * 0.0606),
        width: width * 0.0970,
        height: height * 0.0437,
        decoration: BoxDecoration(
          color: isSelectDate[dateIndex]
              ? backgroundActiveButton
              : backGroundButton,
          border: isSelectDate[dateIndex]
              ? Border.all(width: 0, color: Colors.transparent)
              : Border.all(width: 1, color: brownBorderButton),
          borderRadius: BorderRadius.circular(200),
        ),
        child: Center(
          child: Text(
            dateIndexMap[dateIndex]!,
            style: isSelectDate[dateIndex]
                ? kfontH1InterWhiteColor()
                : kfontH1InterBoldBlackColor(),
          ),
        ),
      ),
    );
  }

  Container headingContainer({required String header}) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        header,
        style: kfontH3InterBlackColor(),
        textAlign: TextAlign.left,
      ),
    );
  }

  Future selectImage() async {
    final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      _shopImagesFileList!.clear();

      _shopImagesFileList!.addAll(selectedImages.take(5));
    } else {
      _shopImagesFileList!.clear();
    }

    setState(() {});
    return _shopImagesFileList;
  }

  void callbackSetStateFunction() {
    setState(() {});
  }
}
