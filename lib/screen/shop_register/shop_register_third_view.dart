import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/data/widget/time_picker.dart';
import 'package:coffee_application/screen/shop_register/shop_register_forth_view.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:coffee_application/screen/my_component/shop_register_statusbar.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:image_picker/image_picker.dart';

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

  Map<int, String> dateIndexMap = {
    0: "จ",
    1: "อ",
    2: "พ",
    3: "พฤ",
    4: "ศ",
    5: "ส",
    6: "อา"
  };

  List<bool> isSelectDate = [false, false, false, false, false, false, false];

  TextEditingController timeController = TextEditingController();

  int openHour = 0;
  int openMinute = 0;
  String openTimeFormat = "AM";

  int closeHour = 0;
  int closeMinute = 0;
  String closeTimeFormat = "AM";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset : false,
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
                          Container(
                              child: Text(
                            "รูปร้าน",
                            style: kfontH3InterBlackColorHalfOpacity(),
                          )),
                          Container(
                              child: Text(
                            ", อาหาร",
                            style: kfontH3InterBlackColorHalfOpacity(),
                          )),
                          Container(
                              child: Text(
                            ", เมนู",
                            style: kfontH3InterBlackColorHalfOpacity(),
                          )),
                          Spacer(),
                          _shopImagesFileList!.isNotEmpty
                              ? GestureDetector(
                                  child: Container(
                                      child: Text(
                                    "แก้ไข / เพิ่ม",
                                    style: kfontH3InterBlackColorHalfOpacity(),
                                  )),
                                  onTap: () {
                                    //TODO edit and add image
                                    selectImage();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const AddEditingImagesList()));
                                  },
                                )
                              : Container(),
                        ]),
                      ),
                    ],
                  ),
                  CarouselSlider.builder(
                    itemCount: _shopImagesFileList!.isNotEmpty
                        ? _shopImagesFileList!.length
                        : 1,
                    options: CarouselOptions(
                        // height: 0,
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                        scrollPhysics: BouncingScrollPhysics(),
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    itemBuilder: (context, index, realIndex) {
                      return _shopImagesFileList!.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                selectImage();
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
                                child: Image.network(
                                    _shopImagesFileList![index].path),
                              ),
                            );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _shopImagesFileList!.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: width * 0.0291,
                          height: height * 0.0131,
                          margin: EdgeInsets.symmetric(
                              vertical: height * 0.008,
                              horizontal: width * 0.0121),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  headingContainer(header: "วันและเวลาของร้าน"),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  Row(
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
                  ),
                  sectionBufferHeight(bufferSection: height * 0.0174),
                  Row(
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
                  ),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  headingContainer(header: "เลือกเวลาเปิด-ปิด"),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  timePickerWidget(title: "OPEN TIME"),
                  Container(
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
                                timeFormat: openTimeFormat,
                                onHourChanged: (value) {
                                  setState(() {
                                    openHour = value;
                                  });
                                },
                                onMinuteChanged: (value) {
                                  setState(() {
                                    openHour = value;
                                  });
                                },
                                onFormatChanged: (value) {
                                  setState(() {
                                    openTimeFormat = value;
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
                              "${openHour.toString().padLeft(2, '0')}:${openMinute.toString().padLeft(2, '0')} $openTimeFormat",
                              style: kfontH1InterBoldBlackColor(),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: width * 0.024),
                            child: Icon(Icons.calendar_view_day_outlined,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sectionBufferHeight(bufferSection: height * 0.0218),
                  timePickerWidget(title: "CLOSE TIME"),
                  Container(
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
                                timeFormat: closeTimeFormat,
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
                                    closeTimeFormat = value;
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
                              "${closeHour.toString().padLeft(2, '0')}:${closeMinute.toString().padLeft(2, '0')} $closeTimeFormat",
                              style: kfontH1InterBoldBlackColor(),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: width * 0.024),
                            child: Icon(Icons.calendar_view_day_outlined,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
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
                                          const ShopRegisterThirdView(),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShopRegisterForthView()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.0194),
                                width: width / 1.7,
                                height: constraints.maxHeight * 0.07,
                                decoration: BoxDecoration(
                                    color: colorAcceptButton,
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
                          Container(
                            child: Text(
                              " < ย้อนกลับ",
                              style: kfontH2InterBlackColor(),
                            ),
                          ),
                          Spacer(),
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

  Row timePickerWidget({required String title}) {
    return Row(
      children: [
        Text(
          title,
          style: kfontH4InterBlackColor(),
        ),
        Spacer(),
        Text(
          "HH:MM AM/PM",
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
    required String timeFormat,
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
                        maxValue: 12,
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

  void selectImage() async {
    final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      _shopImagesFileList!.clear();

      _shopImagesFileList!.addAll(selectedImages.take(3));
    } else {
      _shopImagesFileList!.clear();
    }

    setState(() {});
  }
}
