import 'dart:io';

import 'package:coffee_application/model/request/customer_review_request.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/screen/my_component/bottom_navigationbar_customer.dart';
import 'package:coffee_application/screen/shop_text_field_form.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/customer_review_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class CustomerReviewPage extends StatefulWidget {
  const CustomerReviewPage({super.key});

  @override
  State<CustomerReviewPage> createState() => _CustomerReviewPageState();
}

class _CustomerReviewPageState extends State<CustomerReviewPage> {
  TextEditingController nameShop = TextEditingController();
  TextEditingController menuShop = TextEditingController();
  TextEditingController comment = TextEditingController();
  ShopModel? shop;
  Menus? menu;

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  int _foodScore = 0;
  int _serviceScore = 0;
  int _placeScore = 0;
  int _worthinessScore = 0;
  int _parkingScore = 0;

  late final CustomerReviewVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = CustomerReviewVM();
    _vm.onUserWhenEnteringReviewPage();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          bottomNavigationBar: const CustomerNavigationBar(
            pageName: "REVIEW",
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
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    top: height * 0.05,
                  ),
                  width: width,
                  height: height,
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                        future: _vm.listAllShopFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return shimmerWaitingCarousel(height, width);
                          } else if (snapshot.hasError) {
                            return Text(
                              "ERROR_MESSAGE.ERROR_LOADING_FAIL".tr(),
                              style: kfont32_400(),
                            );
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              !snapshot.hasError) {
                            List<ShopModel> listAllShop = snapshot.data!;
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "CUSTOMER_REVIEW.REVIEW_TITLE".tr(),
                                      style: kfontH0InterBlackColor(),
                                    ),
                                  ),
                                  sectionBufferHeight(
                                      bufferSection: height * 0.01),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "CUSTOMER_REVIEW.SHOP_DROPDOWN_HEADER"
                                          .tr(),
                                      style: kfontH2InterBlackColor(),
                                    ),
                                  ),
                                  dropdownButtonShopName(
                                    height: height,
                                    width: width,
                                    header:
                                        "CUSTOMER_REVIEW.SHOP_DROPDOWN_HEADER",
                                    shopNames: listAllShop,
                                  ),
                                  sectionBufferHeight(
                                      bufferSection: height * 0.01),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "เมนู".tr(),
                                      style: kfontH2InterBlackColor(),
                                    ),
                                  ),
                                  dropdownButtonMenuName(
                                    height: height,
                                    width: width,
                                    header: "เมนู",
                                    menuName: shop != null ? shop!.menus! : [],
                                  ),
                                  sectionBufferHeight(
                                    bufferSection: height * 0.05,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "รสชาติ",
                                      style: kfontH2InterBlackColor(),
                                    ),
                                  ),
                                  _foodSection(height: height),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "บริการ",
                                      style: kfontH2InterBlackColor(),
                                    ),
                                  ),
                                  _serviceSection(height: height),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "สถานที่",
                                      style: kfontH2InterBlackColor(),
                                    ),
                                  ),
                                  _placeSection(height: height),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "ความคุ้มค่า",
                                      style: kfontH2InterBlackColor(),
                                    ),
                                  ),
                                  _worthinessSection(height: height),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "ที่จอดรถ",
                                      style: kfontH2InterBlackColor(),
                                    ),
                                  ),
                                  _parkingSection(height: height),
                                  sectionBufferHeight(
                                    bufferSection: height * 0.05,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "รูปภาพ",
                                      style: kfontH2InterBlackColor(),
                                    ),
                                  ),
                                  _selectedImage != null
                                      ? Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.all(16),
                                          width: width * 0.606,
                                          height: height * 0.1639,
                                          decoration: BoxDecoration(
                                              color: backGroundButton,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: FittedBox(
                                            clipBehavior: Clip.hardEdge,
                                            fit: BoxFit.fill,
                                            child: Image.file(
                                                File(_selectedImage!.path)),
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.all(16),
                                          width: width * 0.606,
                                          height: height * 0.1639,
                                          decoration: BoxDecoration(
                                            color: backGroundButton,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _pickImageFromGallery();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color: fontMenuNameColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "camera ",
                                                    style:
                                                        kfontH2InterWhiteColor(),
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "gallery ",
                                                    style:
                                                        kfontH2InterWhiteColor(),
                                                  ),
                                                  const WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: Colors.white))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  sectionBufferHeight(
                                    bufferSection: height * 0.05,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "ความเห็นอยากอธิบายเพิ่มเติม (optional)",
                                      style: kfontH2InterBlackColor(),
                                    ),
                                  ),
                                  sectionBufferHeight(
                                    bufferSection: height * 0.01,
                                  ),
                                  TextFieldContainer(
                                    hightContainer: height * 0.191,
                                    controller: comment,
                                    hintText: "Comment",
                                  ),
                                  sectionBufferHeight(
                                    bufferSection: height * 0.01,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _vm
                                          .onUserSubmitReview(
                                            review: CustomerReviewRequestBody(
                                              iShopId: shop!.iId!,
                                              menuName: menu!.name,
                                              flavour: _foodScore,
                                              place: _placeScore,
                                              service: _serviceScore,
                                              parking: _parkingScore,
                                              worthiness: _worthinessScore,
                                              comment: comment.text,
                                            ),
                                          )
                                          .then((value) => {
                                                if (value)
                                                  {
                                                    //clear all field
                                                    _clearField(),
                                                    Utility.toastMessage(
                                                        "บันทึกข้อมูลสําเร็จ")
                                                  }
                                                else
                                                  {
                                                    Utility.toastMessage(
                                                        "บันทึกข้อมูลไม่สําเร็จ")
                                                  }
                                              });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: width,
                                      padding: EdgeInsets.symmetric(
                                        vertical: height * 0.01,
                                        horizontal: width * 0.05,
                                      ),
                                      decoration:
                                          kdecorationForContainerAcceptButton,
                                      child: Text(
                                        "ตกลง",
                                        style: kfontH0InterBlackColor(),
                                      ),
                                    ),
                                  ),
                                  sectionBufferHeight(
                                    bufferSection: height * 0.01,
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  //create clear field
  void _clearField() {
    setState(() {
      _foodScore = 0;
      _placeScore = 0;
      _serviceScore = 0;
      _parkingScore = 0;
      _worthinessScore = 0;
      comment.clear();
      _selectedImage = null;
      nameShop.clear();
      menuShop.clear();

      shop = null;
      menu = null;
    });
  }

  Row _serviceSection({required double height}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _serviceScore = 1;
              });
            },
            isSelected: _serviceScore >= 1),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _serviceScore = 2;
              });
            },
            isSelected: _serviceScore >= 2),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _serviceScore = 3;
              });
            },
            isSelected: _serviceScore >= 3),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _serviceScore = 4;
              });
            },
            isSelected: _serviceScore >= 4),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _serviceScore = 5;
              });
            },
            isSelected: _serviceScore >= 5),
      ],
    );
  }

  Row _placeSection({required double height}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _placeScore = 1;
              });
            },
            isSelected: _placeScore >= 1),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _placeScore = 2;
              });
            },
            isSelected: _placeScore >= 2),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _placeScore = 3;
              });
            },
            isSelected: _placeScore >= 3),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _placeScore = 4;
              });
            },
            isSelected: _placeScore >= 4),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _placeScore = 5;
              });
            },
            isSelected: _placeScore >= 5),
      ],
    );
  }

  Row _worthinessSection({required double height}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _worthinessScore = 1;
              });
            },
            isSelected: _worthinessScore >= 1),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _worthinessScore = 2;
              });
            },
            isSelected: _worthinessScore >= 2),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _worthinessScore = 3;
              });
            },
            isSelected: _worthinessScore >= 3),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _worthinessScore = 4;
              });
            },
            isSelected: _worthinessScore >= 4),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _worthinessScore = 5;
              });
            },
            isSelected: _worthinessScore >= 5),
      ],
    );
  }

  Row _parkingSection({required double height}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _parkingScore = 1;
              });
            },
            isSelected: _parkingScore >= 1),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _parkingScore = 2;
              });
            },
            isSelected: _parkingScore >= 2),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _parkingScore = 3;
              });
            },
            isSelected: _parkingScore >= 3),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _parkingScore = 4;
              });
            },
            isSelected: _parkingScore >= 4),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _parkingScore = 5;
              });
            },
            isSelected: _parkingScore >= 5),
      ],
    );
  }

  Row _foodSection({required double height}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _foodScore = 1;
              });
            },
            isSelected: _foodScore >= 1),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _foodScore = 2;
              });
            },
            isSelected: _foodScore >= 2),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _foodScore = 3;
              });
            },
            isSelected: _foodScore >= 3),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _foodScore = 4;
              });
            },
            isSelected: _foodScore >= 4),
        _starIconButton(
            height: height,
            onPressed: () {
              setState(() {
                _foodScore = 5;
              });
            },
            isSelected: _foodScore >= 5),
      ],
    );
  }

  IconButton _starIconButton({
    required double height,
    required Function onPressed,
    required bool isSelected,
  }) {
    return IconButton(
        onPressed: () {
          onPressed();
        },
        icon: Icon(
          isSelected ? Icons.star : Icons.star_border,
          size: height * 0.05,
          color: Colors.amber.shade400,
        ));
  }

  Shimmer shimmerWaitingCarousel(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            width: width * 0.5,
            height: height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.05),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: width * 0.01),
              width: width * 0.2,
              height: height * 0.02,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.01),
          Container(
            width: width,
            height: height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.05),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: width * 0.01),
              width: width * 0.2,
              height: height * 0.02,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.01),
          Container(
            width: width,
            height: height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.05),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: width * 0.01),
              width: width * 0.2,
              height: height * 0.02,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.01),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
          ]),
          sectionBufferHeight(bufferSection: height * 0.02),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: width * 0.01),
              width: width * 0.2,
              height: height * 0.02,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.01),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
          ]),
          sectionBufferHeight(bufferSection: height * 0.02),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: width * 0.01),
              width: width * 0.2,
              height: height * 0.02,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.01),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
          ]),
          sectionBufferHeight(bufferSection: height * 0.02),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: width * 0.01),
              width: width * 0.2,
              height: height * 0.02,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.01),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
          ]),
          sectionBufferHeight(bufferSection: height * 0.02),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: width * 0.01),
              width: width * 0.2,
              height: height * 0.02,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
            ),
          ),
          sectionBufferHeight(bufferSection: height * 0.01),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
            Icon(Icons.star, size: height * 0.05),
          ]),
          sectionBufferHeight(bufferSection: height * 0.02),
          
        ],
        
      ),
    );
  }

  DropdownSearchData<Menus> dropdownSearchBoxMenuName(
      {required height, required width}) {
    return DropdownSearchData(
      searchController: menuShop,
      searchInnerWidgetHeight: height * 0.0546,
      searchInnerWidget: Container(
        height: height * 0.0546,
        padding: EdgeInsets.only(
          top: height * 0.008,
          bottom: height * 0.004,
          right: width * 0.0194,
          left: width * 0.0194,
        ),
        child: TextFormField(
            expands: true,
            maxLines: null,
            controller: menuShop,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.024,
                vertical: height * 0.008,
              ),
              hintText: 'Search for an item...',
              hintStyle: kfontH4InterBlackColorHalfOpacity(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            )),
      ),
      searchMatchFn: (item, searchValue) {
        return item.value!.name
            .toString()
            .toLowerCase()
            .contains(searchValue.toLowerCase());
      },
    );
  }

  DropdownSearchData<ShopModel> dropdownSearchBoxShopName(
      {required height, required width}) {
    return DropdownSearchData(
      searchController: nameShop,
      searchInnerWidgetHeight: height * 0.0546,
      searchInnerWidget: Container(
        height: height * 0.0546,
        padding: EdgeInsets.only(
          top: height * 0.008,
          bottom: height * 0.004,
          right: width * 0.0194,
          left: width * 0.0194,
        ),
        child: TextFormField(
            expands: true,
            maxLines: null,
            controller: nameShop,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.024,
                vertical: height * 0.008,
              ),
              hintText: 'Search for an item...',
              hintStyle: kfontH4InterBlackColorHalfOpacity(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            )),
      ),
      searchMatchFn: (item, searchValue) {
        return item.value!.name
            .toString()
            .toLowerCase()
            .contains(searchValue.toLowerCase());
      },
    );
  }

  MenuItemStyleData menuItemStyleBox({required height}) {
    return MenuItemStyleData(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      height: height * 0.0437,
    );
  }

  DropdownStyleData dropdownStyleBox({required height}) {
    return DropdownStyleData(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      maxHeight: height * 0.2185,
    );
  }

  ButtonStyleData buttonStyleDropDown({required height, required width}) {
    return ButtonStyleData(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: const Color.fromRGBO(226, 199, 153, 1),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.symmetric(horizontal: width * 0.0388),
      height: height * 0.0437,
      width: double.infinity,
    );
  }

  DropdownButtonHideUnderline dropdownButtonShopName(
      {required String header,
      required height,
      required width,
      required List<ShopModel> shopNames}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ShopModel>(
        items: shopNames.map((ShopModel shop) {
          return DropdownMenuItem<ShopModel>(
            value: shop,
            child: Text(shop.name!),
          );
        }).toList(),
        value: shop,
        hint: Text(
          header.tr(),
          style: kfontH4InterBlackColorHalfOpacity(),
        ),
        onChanged: (value) {
          setState(() {
            shop = value;
          });
        },
        buttonStyleData: buttonStyleDropDown(height: height, width: width),
        dropdownStyleData: dropdownStyleBox(height: height),
        menuItemStyleData: menuItemStyleBox(height: height),
        dropdownSearchData:
            dropdownSearchBoxShopName(height: height, width: width),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          setState(() {
            if (isOpen) {
              nameShop.clear();
              shop = null;
              menu = null;
            }
          });
        },
      ),
    );
  }

  DropdownButtonHideUnderline dropdownButtonMenuName(
      {required String header,
      required height,
      required width,
      required List<Menus> menuName}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Menus>(
        items: shop != null
            ? menuName.map((Menus menu) {
                return DropdownMenuItem<Menus>(
                  value: menu,
                  child: menu.name == null
                      ? Text(
                          "ไม่มีชื่อเมนู",
                          style: kfontH2InterBoldBlackColor(),
                        )
                      : Text(
                          menu.name!,
                          style: kfontH2InterBlackColor(),
                        ),
                );
              }).toList()
            : <DropdownMenuItem<Menus>>[],
        value: menu,
        hint: Text(
          header.tr(),
          style: kfontH4InterBlackColorHalfOpacity(),
        ),
        onChanged: (value) {
          setState(() {
            menu = value;
          });
        },
        buttonStyleData: buttonStyleDropDown(height: height, width: width),
        dropdownStyleData: dropdownStyleBox(height: height),
        menuItemStyleData: menuItemStyleBox(height: height),
        dropdownSearchData:
            dropdownSearchBoxMenuName(height: height, width: width),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          setState(() {
            if (isOpen) {
              menuShop.clear();
              menu = null;
            }
          });
        },
      ),
    );
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
}
