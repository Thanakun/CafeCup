import 'package:coffee_application/data/widget/button_selection_animate.dart';
import 'package:coffee_application/provider/customer-provider.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/viewmodel/register_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:coffee_application/screen/my_component/shop_register_statusbar.dart';
import 'package:coffee_application/screen/shop_information.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:provider/provider.dart';

class ShopRegisterForthView extends StatefulWidget {
  const ShopRegisterForthView({super.key});

  @override
  State<ShopRegisterForthView> createState() => _ShopRegisterForthViewState();
}

enum CustomerGroup {
  STUDENT,
  OFFICE_WORKER,
  TOURIST,
  DIGITAL_NOMAD,
  TAKEAWAY,
}

class _ShopRegisterForthViewState extends State<ShopRegisterForthView> {
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

  late final RegisterVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = RegisterVM(
        customerProvider: context.read<CustomerProvider>(),
        shopProvider: context.read<ShopProvider>());
    tableButton = createButtonStateMap(listOfTableType);
    facilitiesButton = createButtonStateMap(listOfFacilitiesType);
    cafeTakePhotoSpot = createButtonStateMap(listOfTakePhotoSpot);
    cafeShopStyle = createButtonStateMap(listOfCafeShopStyle);
    cafeNoiseType = createButtonStateMap(listOfCafeNoice);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(255, 245, 233, 1),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedContainer(
                  duration: Duration(seconds: 15),
                  child: Container(
                    width: width,
                    height: height,
                    margin: EdgeInsets.only(
                        left: width * 0.07281,
                        right: width * 0.07281,
                        top: height * 0.0163),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ShopStatusBarRegister(
                            shopIndicatorRegistationState: 4,
                          ),
                          sectionBufferHeight(bufferSection: height * 0.0218),
                          Container(
                            child: Center(
                              child: Text(
                                "รายละเอียดภาพรวมของร้าน",
                                style: kfontH1InterBoldBlackColor(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          sectionBufferHeight(bufferSection: height * 0.0163),
                          headingContainer(
                              header: "เลือกลูกค้าส่วนใหญ่ที่เข้ามาในร้าน"),
                          sectionBufferHeight(bufferSection: height * 0.0109),
                          DropdownMenu<CustomerGroup>(
                            width: width * 0.849,

                            inputDecorationTheme: InputDecorationTheme(
                                floatingLabelStyle: kfontH2InterBlackColor(),
                                filled: true,
                                labelStyle: kfontH3InterBlackColor(),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                                constraints: BoxConstraints(
                                  minWidth: double.infinity,
                                  maxWidth: double.infinity,
                                ),
                                outlineBorder: BorderSide(),
                                fillColor: backgroundActiveButton),

                            // initialSelection: ,
                            menuStyle: MenuStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    backgroundActiveButton)),
                            leadingIcon: Icon(Icons.people_alt),
                            controller: selectedCustomerGroup,

                            requestFocusOnTap: false,
                            textStyle: kfontH2InterBoldBlackColor(),

                            hintText: "enter the customer group",
                            onSelected: (CustomerGroup? group) {
                              setState(() {
                                groupValueSelect = group!;
                              });
                            },
                            dropdownMenuEntries: CustomerGroup.values
                                .map<DropdownMenuEntry<CustomerGroup>>(
                                    (CustomerGroup group) {
                              return DropdownMenuEntry<CustomerGroup>(
                                labelWidget: Text(
                                  "CUSTOMER_SEARCH_RESULT.${group.name}".tr(),
                                  style: kfontH2InterBoldBlackColor(),
                                ),
                                value: groupValueSelect,
                                label:
                                    "CUSTOMER_SEARCH_RESULT.${group.name}".tr(),
                              );
                            }).toList(),
                          ),
                          sectionBufferHeight(bufferSection: height * 0.0218),
                          headingContainer(
                              header:
                                  "ประเภทของโต๊ะที่นั่งที่มี ( หลายตัวเลือก )"),
                          sectionBufferHeight(bufferSection: height * 0.0109),
                          Container(
                            height: constraints.maxHeight / 9,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: ListView.builder(
                                      // itemExtent: ,
                                      physics: const BouncingScrollPhysics(
                                          decelerationRate:
                                              ScrollDecelerationRate.normal),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tableButton.length,
                                      itemBuilder: (context, index) {
                                        String buttonName =
                                            tableButton.keys.elementAt(index);
                                        bool isButtonPressed =
                                            tableButton[buttonName] ?? false;

                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: width * 0.0485),
                                          child: selectTableSection(
                                            width: width,
                                            height: height,
                                            controller:
                                                textEditingControllers[index],
                                            nameButton: buttonName,
                                            onTap: () {
                                              setState(() {
                                                tableButton[buttonName] =
                                                    !isButtonPressed;
                                                if (!isButtonPressed) {
                                                  textEditingControllers[index]
                                                      .text = "";
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
                          ),
                          sectionBufferHeight(bufferSection: height * 0.0218),
                          headingContainer(
                              header: "สิ่งอำนวยความสะดวกเบื้องต้น "),
                          sectionBufferHeight(bufferSection: height * 0.0109),
                          Container(
                            height: 60,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(
                                          decelerationRate:
                                              ScrollDecelerationRate.normal),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: facilitiesButton.length,
                                      itemBuilder: (context, index) {
                                        String buttonName = facilitiesButton
                                            .keys
                                            .elementAt(index);
                                        bool isButtonPressed =
                                            facilitiesButton[buttonName] ??
                                                false;

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ButtonSelectionAnimation(
                                            onTap: () {
                                              setState(() {
                                                facilitiesButton[buttonName] =
                                                    !isButtonPressed;
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
                          ),
                          sectionBufferHeight(bufferSection: height * 0.0218),
                          headingContainer(header: "มุมถ่ายรูป"),
                          sectionBufferHeight(bufferSection: height * 0.0109),
                          Container(
                            height: 60,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(
                                          decelerationRate:
                                              ScrollDecelerationRate.normal),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cafeTakePhotoSpot.length,
                                      itemBuilder: (context, index) {
                                        String buttonName = cafeTakePhotoSpot
                                            .keys
                                            .elementAt(index);
                                        bool isButtonPressed =
                                            cafeTakePhotoSpot[buttonName] ??
                                                false;

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ButtonSelectionAnimation(
                                            onTap: () {
                                              setState(() {
                                                cafeTakePhotoSpot
                                                    .forEach((key, value) {
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
                                            nameButton:
                                                "BUTTON.$buttonName".tr(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          sectionBufferHeight(bufferSection: height * 0.0218),
                          headingContainer(header: "สถานที่"),
                          sectionBufferHeight(bufferSection: height * 0.0109),
                          Container(
                            height: height * 0.0655,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(
                                          decelerationRate:
                                              ScrollDecelerationRate.normal),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cafeShopStyle.length,
                                      itemBuilder: (context, index) {
                                        String buttonName =
                                            cafeShopStyle.keys.elementAt(index);
                                        bool isButtonPressed =
                                            cafeShopStyle[buttonName] ?? false;

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ButtonSelectionAnimation(
                                            onTap: () {
                                              setState(() {
                                                cafeShopStyle
                                                    .forEach((key, value) {
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
                          ),
                          sectionBufferHeight(bufferSection: height * 0.0218),
                          headingContainer(header: "เสียงภายในร้าน"),
                          sectionBufferHeight(bufferSection: height * 0.0109),
                          Container(
                            height: 60,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(
                                          decelerationRate:
                                              ScrollDecelerationRate.normal),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cafeNoiseType.length,
                                      itemBuilder: (context, index) {
                                        String buttonName =
                                            cafeNoiseType.keys.elementAt(index);
                                        bool isButtonPressed =
                                            cafeNoiseType[buttonName] ?? false;

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ButtonSelectionAnimation(
                                            onTap: () {
                                              setState(() {
                                                cafeNoiseType
                                                    .forEach((key, value) {
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
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (selectedCustomerGroup.text.isEmpty ||
                                          (tableButton['โต๊ะเดี่ยว'] == false &&
                                              tableButton['โต๊ะคู่'] == false &&
                                              tableButton['โต๊ะใหญ่'] ==
                                                  false) ||
                                          !facilitiesButton
                                              .containsValue(true) ||
                                          !cafeTakePhotoSpot
                                              .containsValue(true) ||
                                          !cafeShopStyle.containsValue(true) ||
                                          !cafeNoiseType.containsValue(true)) {
                                        // Display an error message or perform some action for invalid input

                                        return Utility.flushBarErrorMessage(
                                            message:
                                                "Please insert data information",
                                            context: context);
                                      }

                                      _vm.shopSignUpForthPage(
                                          customerGroup: groupValueSelect.name,
                                          singleSeat: textEditingControllers[0]
                                                  .text
                                                  .isEmpty
                                              ? 0
                                              : int.parse(
                                                  textEditingControllers[0]
                                                      .text),
                                          doubleSeat: textEditingControllers[1]
                                                  .text
                                                  .isEmpty
                                              ? 0
                                              : int.parse(
                                                  textEditingControllers[1]
                                                      .text),
                                          largeSeat: textEditingControllers[2]
                                                  .text
                                                  .isEmpty
                                              ? 0
                                              : int.parse(
                                                  textEditingControllers[2]
                                                      .text),
                                          facilities: facilitiesButton,
                                          cafeTakePhotoSpot: cafeTakePhotoSpot,
                                          cafeShopStyle: cafeShopStyle,
                                          cafeNoiseLevel: cafeNoiseType);

                                      _vm.signUp(
                                          shop:
                                              context.read<ShopProvider>().shop,
                                          customer: context
                                              .read<CustomerProvider>()
                                              .customer,
                                          userType: "Shop");
                                      setState(() {});
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const ShopInformationPage()));
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      width: width / 1.7,
                                      height: constraints.maxHeight * 0.07,
                                      decoration: BoxDecoration(
                                          color: kcolorAcceptButton,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
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
                          ),
                        ]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
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
