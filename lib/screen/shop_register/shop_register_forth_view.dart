import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/screen/my_component/shop_register_statusbar.dart';
import 'package:flutter_application_1/screen/shop_information.dart';
import 'package:flutter_application_1/utility/my_constant.dart';

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
  List<String> listOfFacilitiesType = ["ไวไฟ (wifi)", "ปลั๊ก", "ห้องประชุม"];
  List<String> listOfTakePhotoSpot = ["< 2", "2 - 7", "> 7"];
  List<String> listOfCafeShopStyle = ["ในร่ม", "กลางแจ้ง", "ผสม"];
  List<String> listOfCafeNoice = ["ห้ามใช้เสียง", "ปกติ"];

  late Map<String, bool> facilitiesButton;
  late Map<String, bool> tableButton;
  late Map<String, bool> cafeTakePhotoSpot;
  late Map<String, bool> cafeShopStyle;
  late Map<String, bool> cafeNoiseType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TextEditingController singleTable = textEditingControllers[0];
    TextEditingController pairTable = textEditingControllers[1];
    TextEditingController bigTable = textEditingControllers[2];
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
        body: Container(
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
                          textStyle: kfontH3InterBlackColor(),

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
                                group.name,
                                style: kfontH2InterBlackColor(),
                              ),
                              value: groupValueSelect,
                              label: group.name,
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
                                      String buttonName = facilitiesButton.keys
                                          .elementAt(index);
                                      bool isButtonPressed =
                                          facilitiesButton[buttonName] ?? false;

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
                                      String buttonName = cafeTakePhotoSpot.keys
                                          .elementAt(index);
                                      bool isButtonPressed =
                                          cafeTakePhotoSpot[buttonName] ??
                                              false;

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ButtonSelectionAnimation(
                                          onTap: () {
                                            setState(() {
                                              cafeTakePhotoSpot[buttonName] =
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
                                              cafeShopStyle[buttonName] =
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
                                              cafeNoiseType[buttonName] =
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
                        const Spacer(),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                      // Navigator.pushReplacement(
                                      //     (context),
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           // const ShopRegisterThirdView(),
                                      //     ));
                                      // Add more logic as needed
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ShopInformationPage()));
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      width: width / 1.7,
                                      height: constraints.maxHeight * 0.07,
                                      decoration: BoxDecoration(
                                          color: colorAcceptButton,
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

class ButtonSelectionAnimation extends StatelessWidget {
  final Function() onTap;
  bool isButtonPressed;
  String nameButton;

  ButtonSelectionAnimation({
    Key? key,
    required this.onTap,
    required this.isButtonPressed,
    required this.nameButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutBack,
        tween: Tween<double>(
          begin: isButtonPressed ? 1.0 : 0.95,
          end: isButtonPressed ? 0.95 : 1.0,
        ),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              // width: 120,
              height: height * 0.0437,
              decoration: BoxDecoration(
                border: isButtonPressed
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: brownBorderButton, width: 2),
                borderRadius: BorderRadius.circular(20),
                color:
                    isButtonPressed ? backgroundActiveButton : backGroundButton,
                boxShadow: isButtonPressed
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(3, 3),
                          blurRadius: 5,
                          // spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: backGroundApplication,
                          offset: Offset(-3, -3),
                          blurRadius: 5,
                          // spreadRadius: 1,
                        )
                      ],
              ),
              child: Center(
                child: Text(
                  nameButton,
                  style: kfontH2InterBlackColor(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
