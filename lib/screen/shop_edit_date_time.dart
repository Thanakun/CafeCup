import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';

class EditDateTime extends StatefulWidget {
  const EditDateTime({super.key, required this.shop});

  final ShopModel shop;
  @override
  State<EditDateTime> createState() => _EditDateTimeState();
}

class _EditDateTimeState extends State<EditDateTime> {
  List<bool> isSelectDate = [false, false, false, false, false, false, false];

  TextEditingController timeController = TextEditingController();

  int openHour = 0;
  int openMinute = 0;
  // String openTimeFormat = "AM";

  int closeHour = 0;
  int closeMinute = 0;
  // String closeTimeFormat = "AM";
  Map<int, String> dateIndexMap = {
    0: "จ",
    1: "อ",
    2: "พ",
    3: "พฤ",
    4: "ศ",
    5: "ส",
    6: "อา"
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            toolbarHeight: height * 0.08,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: backGroundApplication,
            centerTitle: true,
            leading: Container(
              margin: EdgeInsets.only(left: width * 0.03),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      size: 40, color: Colors.black),
                  onPressed: () {
                    //POP

                    _showConfirmationDialog(context, width, height)
                        .then((value) {
                      if (value == 2) {
                        widget.shop.daysOpen!.clear();
                        for (int i = 0; i < isSelectDate.length; i++) {
                          if (isSelectDate[i]) {
                            // Adding (i + 1) when the day is open
                            widget.shop.daysOpen!.add(i + 1);
                          }
                        }
                        widget.shop.timeOpen =
                            conCatTimeFormat(openHour, openMinute);
                        widget.shop.timeClose =
                            conCatTimeFormat(closeHour, closeMinute);
                        Navigator.pop(context, true);
                      } else if (value == 1) {
                        return;
                      } else if (value == 0) {
                        Navigator.pop(context, false);
                      }
                    });
                  }),
            )),
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundCustomerImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(
                  top: height * 0.03, left: width * 0.07, right: width * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _showConfirmationDialog(BuildContext context, width, height) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backGroundApplication,
          surfaceTintColor: Colors.transparent,
          title: Text("ALERT_DIALOG.CONFIRMATION".tr(), style: kfont32_400()),
          content: Text(
            'ALERT_DIALOG.CONFIRMATION_MESSAGE'.tr(),
            style: kfontH1InterBoldBlackColor(),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(0); // Close the dialog
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.0242, vertical: height * 0.0109),
                decoration: kdecorationButtonUnSelectedOrange,
                child: Text('ALERT_DIALOG.CANCEL'.tr(),
                    style: kfontH2InterBlackColor()),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(
                  1,
                ); // Close the dialog
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.0242, vertical: height * 0.0109),
                decoration: kdecorationButtonDisableContainer,
                child: Text(
                  "ALERT_DIALOG.STAY_IN_THIS_PAGE".tr(),
                  style: kfontH2InterBlackColor(),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(
                  2,
                ); // Close the dialog
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.0242, vertical: height * 0.0109),
                decoration: kdecorationButtonSelectedOrange,
                child: Text(
                  "ALERT_DIALOG.CONFIRM".tr(),
                  style: kfontH2InterBlackColor(),
                ),
              ),
            ),
          ],
        );
      },
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

  String conCatTimeFormat(int hour, int minute) {
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');
    return "$formattedHour:$formattedMinute";
  }
}

// sectionBufferHeight(bufferSection: height * 0.0218),
//                   headingContainer(header: "วันและเวลาของร้าน"),
//                   sectionBufferHeight(bufferSection: height * 0.0218),
//                   _pickdateOpen(width, height),
//                   sectionBufferHeight(bufferSection: height * 0.0174),
//                   _pickdateOpenSecond(width, height),
//                   sectionBufferHeight(bufferSection: height * 0.0218),
//                   headingContainer(header: "เลือกเวลาเปิด-ปิด"),
//                   sectionBufferHeight(bufferSection: height * 0.0218),
//                   timePickerWidget(title: "OPEN TIME"),
//                   _pickTimeOpen(height, context, width),
//                   sectionBufferHeight(bufferSection: height * 0.0218),
//                   timePickerWidget(title: "CLOSE TIME"),
//                   _pickTimeClose(height, context, width),