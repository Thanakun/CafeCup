import 'package:coffee_application/data/widget/button_selection_animate.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShopEditProfileView extends StatefulWidget {
  const ShopEditProfileView({super.key});

  @override
  State<ShopEditProfileView> createState() => _ShopEditProfileViewState();
}

enum CustomerGroup {
  STUDENT,
  OFFICE_WORKER,
  TOURIST,
  DIGITAL_NORMAD,
  TAKEAWAY,
}

class _ShopEditProfileViewState extends State<ShopEditProfileView> {
  TextEditingController selectedCustomerGroup = TextEditingController();
  List<TextEditingController> textEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  CustomerGroup groupValueSelect = CustomerGroup.STUDENT;
  List<String> listOfTableType = ["โต๊ะเดี่ยว", "โต๊ะคู่", "โต๊ะใหญ่"];
  List<String> listOfFacilitiesType = [
    "ไวไฟ (wifi)",
    "ปลั๊ก",
    "ห้องประชุม",
    "ห้องน้ำ",
    "ที่สูบบุหรี่"
  ];
  List<String> listOfTakePhotoSpot = ["FEW", "MEDIUM", "MUCH"];
  List<String> listOfCafeShopStyle = ["ในร่ม", "กลางแจ้ง", "ผสม"];
  List<String> listOfCafeNoice = ["ห้ามใช้เสียง", "ปกติ"];

  late Map<String, bool> facilitiesButton;
  late Map<String, bool> tableButton;
  late Map<String, bool> cafeTakePhotoSpot;
  late Map<String, bool> cafeShopStyle;
  late Map<String, bool> cafeNoiseType;

  @override
  void initState() {
    tableButton = createButtonStateMap(listOfTableType);
    facilitiesButton = createButtonStateMap(listOfFacilitiesType);
    cafeTakePhotoSpot = createButtonStateMap(listOfTakePhotoSpot);
    cafeShopStyle = createButtonStateMap(listOfCafeShopStyle);
    cafeNoiseType = createButtonStateMap(listOfCafeNoice);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

        ),
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
                      horizontal: width * 0.05, vertical: height * 0.0163),
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      Text(
                        'แก้ไขโปรไฟล์',
                        style: kfontH0InterBlackColor(),
                      ),
                      sectionBufferHeight(bufferSection: height * 0.01),
                      sectionBufferHeight(bufferSection: height * 0.0218),
                      _customerGroupSection(width),
                      sectionBufferHeight(bufferSection: height * 0.0218),
                      _tableSelectionSection(constraints, width, height),
                      sectionBufferHeight(bufferSection: height * 0.0218),
                      headingContainer(header: "สิ่งอำนวยความสะดวกเบื้องต้น "),
                      sectionBufferHeight(bufferSection: height * 0.0109),
                      _listFacilitiesSection(),
                      sectionBufferHeight(bufferSection: height * 0.0218),
                      headingContainer(header: "มุมถ่ายรูป"),
                      sectionBufferHeight(bufferSection: height * 0.0109),
                      _photoTakingSection(),
                      sectionBufferHeight(bufferSection: height * 0.0218),
                      headingContainer(header: "สถานที่"),
                      sectionBufferHeight(bufferSection: height * 0.0109),
                      _shopCafeStyle(height),
                      sectionBufferHeight(bufferSection: height * 0.0218),
                      headingContainer(header: "เสียงภายในร้าน"),
                      sectionBufferHeight(bufferSection: height * 0.0109),
                      _shopNoiseType(),
                      sectionBufferHeight(bufferSection: height * 0.1),
                      _confirmSection(context, width, constraints),
                    ]),
                  ));
            },
          ),
        ),
      ),
    );
  }

  Column _confirmSection(
      BuildContext context, double width, BoxConstraints constraints) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (selectedCustomerGroup.text.isEmpty ||
                    (tableButton['โต๊ะเดี่ยว'] == false &&
                        tableButton['โต๊ะคู่'] == false &&
                        tableButton['โต๊ะใหญ่'] == false) ||
                    !facilitiesButton.containsValue(true) ||
                    !cafeTakePhotoSpot.containsValue(true) ||
                    !cafeShopStyle.containsValue(true) ||
                    !cafeNoiseType.containsValue(true)) {
                  // Display an error message or perform some action for invalid input

                  return Utility.flushBarErrorMessage(
                      message: "Please insert data information",
                      context: context);
                }

                // _vm.shopSignUpForthPage(
                //     customerGroup: groupValueSelect.name,
                //     singleSeat: textEditingControllers[0].text.isEmpty
                //         ? 0
                //         : int.parse(textEditingControllers[0].text),
                //     doubleSeat: textEditingControllers[1].text.isEmpty
                //         ? 0
                //         : int.parse(textEditingControllers[1].text),
                //     largeSeat: textEditingControllers[2].text.isEmpty
                //         ? 0
                //         : int.parse(textEditingControllers[2].text),
                //     facilities: facilitiesButton,
                //     cafeTakePhotoSpot: cafeTakePhotoSpot,
                //     cafeShopStyle: cafeShopStyle,
                //     cafeNoiseLevel: cafeNoiseType);

                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                width: width / 1.7,
                height: constraints.maxHeight * 0.07,
                decoration: const BoxDecoration(
                    color: kcolorAcceptButton,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Center(
                  child: Text(
                    "CONFIRM",
                    style: kfontH1InterBoldBlackColor(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _shopNoiseType() {
    return Container(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: cafeNoiseType.length,
                itemBuilder: (context, index) {
                  String buttonName = cafeNoiseType.keys.elementAt(index);
                  bool isButtonPressed = cafeNoiseType[buttonName] ?? false;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonSelectionAnimation(
                      onTap: () {
                        setState(() {
                          cafeNoiseType.forEach((key, value) {
                            if (key == buttonName) {
                              cafeNoiseType[key] =
                                  !isButtonPressed; // Toggle the value
                            } else {
                              cafeNoiseType[key] =
                                  false; // Set other buttons to false
                            }
                          });
                        });
                      },
                      isButtonPressed: isButtonPressed,
                      nameButton: buttonName,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _shopCafeStyle(double height) {
    return Container(
      height: height * 0.0655,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: cafeShopStyle.length,
                itemBuilder: (context, index) {
                  String buttonName = cafeShopStyle.keys.elementAt(index);
                  bool isButtonPressed = cafeShopStyle[buttonName] ?? false;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonSelectionAnimation(
                      onTap: () {
                        setState(() {
                          cafeShopStyle.forEach((key, value) {
                            if (key == buttonName) {
                              cafeShopStyle[key] =
                                  !isButtonPressed; // Toggle the value
                            } else {
                              cafeShopStyle[key] =
                                  false; // Set other buttons to false
                            }
                          });
                        });
                      },
                      isButtonPressed: isButtonPressed,
                      nameButton: buttonName,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _photoTakingSection() {
    return Container(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: cafeTakePhotoSpot.length,
                itemBuilder: (context, index) {
                  String buttonName = cafeTakePhotoSpot.keys.elementAt(index);
                  bool isButtonPressed = cafeTakePhotoSpot[buttonName] ?? false;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonSelectionAnimation(
                      onTap: () {
                        setState(() {
                          cafeTakePhotoSpot.forEach((key, value) {
                            if (key == buttonName) {
                              cafeTakePhotoSpot[key] =
                                  !isButtonPressed; // Toggle the value
                            } else {
                              cafeTakePhotoSpot[key] =
                                  false; // Set other buttons to false
                            }
                          });
                        });
                      },
                      isButtonPressed: isButtonPressed,
                      nameButton: "BUTTON.$buttonName".tr(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _listFacilitiesSection() {
    return Container(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: facilitiesButton.length,
                itemBuilder: (context, index) {
                  String buttonName = facilitiesButton.keys.elementAt(index);
                  bool isButtonPressed = facilitiesButton[buttonName] ?? false;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonSelectionAnimation(
                      onTap: () {
                        setState(() {
                          facilitiesButton[buttonName] = !isButtonPressed;
                        });
                      },
                      isButtonPressed: isButtonPressed,
                      nameButton: buttonName,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _tableSelectionSection(
      BoxConstraints constraints, double width, double height) {
    return SizedBox(
      height: constraints.maxHeight / 8,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                // itemExtent: ,
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: tableButton.length,
                itemBuilder: (context, index) {
                  String buttonName = tableButton.keys.elementAt(index);
                  bool isButtonPressed = tableButton[buttonName] ?? false;

                  return Container(
                    margin: EdgeInsets.only(left: width * 0.0485),
                    child: selectTableSection(
                      width: width,
                      height: height,
                      controller: textEditingControllers[index],
                      nameButton: buttonName,
                      onTap: () {
                        setState(() {
                          tableButton[buttonName] = !isButtonPressed;
                          if (!isButtonPressed) {
                            textEditingControllers[index].text = "";
                          }
                        });
                      },
                      buttonTable: isButtonPressed,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenu<CustomerGroup> _customerGroupSection(double width) {
    return DropdownMenu<CustomerGroup>(
      width: width * 0.849,

      inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: kfontH2InterBlackColor(),
          filled: true,
          labelStyle: kfontH3InterBlackColor(),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          constraints: const BoxConstraints(
            minWidth: double.infinity,
            maxWidth: double.infinity,
          ),
          outlineBorder: const BorderSide(),
          fillColor: backgroundActiveButton),

      // initialSelection: ,
      menuStyle: const MenuStyle(
          backgroundColor: MaterialStatePropertyAll(backgroundActiveButton)),
      leadingIcon: const Icon(Icons.people_alt),
      controller: selectedCustomerGroup,

      requestFocusOnTap: false,
      textStyle: kfontH2InterBoldBlackColor(),

      hintText: "กลุ่มลูกค้าที่เข้ามาในร้านของคุณ",
      onSelected: (CustomerGroup? group) {
        setState(() {
          groupValueSelect = group!;
        });
      },
      dropdownMenuEntries: CustomerGroup.values
          .map<DropdownMenuEntry<CustomerGroup>>((CustomerGroup group) {
        return DropdownMenuEntry<CustomerGroup>(
          labelWidget: Text(
            "CUSTOMER_SEARCH_RESULT.${group.name}".tr(),
            style: kfontH2InterBoldBlackColor(),
          ),
          value: groupValueSelect,
          label: "CUSTOMER_SEARCH_RESULT.${group.name}".tr(),
        );
      }).toList(),
    );
  }

  Column selectTableSection(
      {required Function() onTap,
      required String nameButton,
      required bool buttonTable,
      required TextEditingController controller,
      required height,
      required width}) {
    return Column(
      children: [
        ButtonSelectionAnimation(
          nameButton: nameButton,
          onTap: onTap,
          isButtonPressed: buttonTable,
        ),
        sectionBufferHeight(bufferSection: height * 0.0109),
        buttonTable
            ? Container(
                width: width * 0.194,
                height: height * 0.054,
                child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  controller: controller,
                  enabled: buttonTable,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: buttonTable ? "จำนวน" : "",
                    filled: true,
                    fillColor:
                        buttonTable ? backgroundActiveButton : backGroundButton,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: buttonTable
                          ? BorderSide.none
                          : const BorderSide(color: brownBorderButton),
                    ),
                  ),
                ),
              ).animate(target: buttonTable ? 1 : 0).slideY()
            : Container()
      ],
    );
  }

  Text headingContainer({required String header}) {
    return Text(
      header,
      style: kfontH2InterBlackColor(),
      textAlign: TextAlign.left,
    );
  }

  Text headerContainer({required String header}) {
    return Text(
      header,
      style: kfontH1InterBoldBlackColor(),
      textAlign: TextAlign.center,
    );
  }

  Map<String, bool> createButtonStateMap(List<String> listOfButton) {
    Map<String, bool> buttonStateMap = {};

    for (String item in listOfButton) {
      buttonStateMap[item] = false;
    }

    return buttonStateMap;
  }
}
