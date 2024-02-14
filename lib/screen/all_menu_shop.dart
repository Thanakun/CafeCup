import 'dart:io';
import 'dart:ui';

import 'package:coffee_application/model/menu.dart';
import 'package:coffee_application/screen/my_component/buttom_navigationbar_shop.dart';
import 'package:coffee_application/screen/shop_text_field_form.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AllMenuShopPage extends StatefulWidget {
  const AllMenuShopPage({super.key});

  @override
  State<AllMenuShopPage> createState() => _AllMenuShopPageState();
}

class _AllMenuShopPageState extends State<AllMenuShopPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  File _file = File("Empty");
  Uint8List webImage = Uint8List(10);

  TextEditingController nameMenu = TextEditingController();
  TextEditingController priceMenu = TextEditingController();
  TextEditingController categoryMenu = TextEditingController();

  final List<String> _itSkills = [
    "IT",
    "Programming",
    "Mediasssssssssssss",
    "System Analyst",
    "Pharma",
    "Pharma1",
    "Pharma2",
    "Pharma3",
    "Pharma4",
    "Pharma5",
    "Pharma6",
    "Pharma7",
    "Pharma8",
    "Pharma9",
    "Pharma0",
    "Pharma10",
    "Pharma11",
    "Pharma12",
    "Business ExecutiveSSSSSSSSSSSSSSs"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
            onTap: () async {
              //TODO Adding Item
              await showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: backGroundApplication,
                  surfaceTintColor: Colors.transparent,
                  content: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: StatefulBuilder(
                            builder: (context, StateSetter setStateDialog) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              _file.path == "Empty"
                                  ? GestureDetector(
                                      onTap: () {
                                        uploadImage(setStateDialog);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(16),
                                        width: width * 0.606,
                                        height: height * 0.1639,
                                        decoration: BoxDecoration(
                                          color: backgroundActiveButton,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                      width: width * 0.606,
                                      height: height * 0.1639,
                                      decoration: BoxDecoration(
                                        color: backgroundActiveButton,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: kIsWeb
                                            ? Image.memory(webImage)
                                            : Image.file(_file),
                                      ),
                                    ),
                              TextFormField(
                                style: kfontH2InterBlackColor(),
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    errorStyle: kfont22_400ErrorStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    constraints:
                                        const BoxConstraints(minHeight: 100),
                                    labelText:
                                        "ALL_SHOP_MENU.LABEL.MENU_NAME".tr(),
                                    labelStyle:
                                        kfontH1InterBlackColorHalfOpacity(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintStyle: kfontH2InterBlackColor()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'ALL_SHOP_MENU.VALIDATOR_FIELD.MENU_NAME'
                                        .tr();
                                  }
                                  return null;
                                },
                                controller: nameMenu,
                              ),
                              TextFormField(
                                style: kfontH2InterBlackColor(),
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    errorStyle: kfont22_400ErrorStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    constraints:
                                        const BoxConstraints(minHeight: 100),
                                    labelText: "ALL_SHOP_MENU.LABEL.PRICE".tr(),
                                    labelStyle:
                                        kfontH1InterBlackColorHalfOpacity(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintStyle: kfontH2InterBlackColor()),
                                validator: Helper.validatePrice,
                                controller: priceMenu,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: kfontH2InterBlackColor(),
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    errorStyle: kfont22_400ErrorStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    constraints:
                                        const BoxConstraints(minHeight: 100),
                                    labelText:
                                        "ALL_SHOP_MENU.LABEL.MENU_NAME.CATEGORY"
                                            .tr(),
                                    labelStyle:
                                        kfontH1InterBlackColorHalfOpacity(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintStyle: kfontH2InterBlackColor()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'ALL_SHOP_MENU.VALIDATOR_FIELD.CATEGORY';
                                  }
                                  return null;
                                },
                                controller: categoryMenu,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        decoration:
                                            kdecorationForContainerButton,
                                        child: Center(
                                          child: Text(
                                            "BUTTON.BACK".tr(),
                                            style: kfontH1InterBoldBlackColor(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: InkResponse(
                                      onTap: () {
                                        if (_file.path == "Empty") {
                                          Utility.snackBarError(
                                              message:
                                                  "ERROR_MESSAGE.PLEASE_SELECT_IMAGE"
                                                      .tr(),
                                              context: context);
                                          return;
                                        }
                                        onSubmit();
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        decoration:
                                            kdecorationForContainerAcceptButton,
                                        child: Center(
                                          child: Text(
                                            "BUTTON_SAVE".tr(),
                                            style: kfontH1InterBoldBlackColor(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: kdecorationForContainerAcceptFloatingButton,
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 35,
                ),
              ),
            )),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "APP_BAR_TITLE.ALL_SHOP_MENU".tr(),
            style: kfont32_400(),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 40, color: Colors.black),
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
          child: Container(
            width: width,
            height: height,
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.07281, vertical: height * 0.0163),
            child: Column(
              children: [
                searchBar(),
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: ReorderableListView.builder(
                      buildDefaultDragHandles: false,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final String item = _itSkills.removeAt(oldIndex);
                          _itSkills.insert(newIndex, item);
                        });
                      },
                      shrinkWrap: true,
                      itemCount: _itSkills.length,
                      itemBuilder: (context, index) {
                        final item = _itSkills[index];

                        return Dismissible(
                          key: ValueKey(item),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              _itSkills.removeAt(index);
                            });
                          },
                          background: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  backgroundActiveButton,
                                  Colors.red,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 10,
                            ),
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: kdecorationForContainerActiveItem,
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: ShapeDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(americanoImagePath),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: [
                                      const BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                                sectionBufferWidth(bufferSection: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 150,
                                      child: Text(
                                        item,
                                        overflow: TextOverflow.ellipsis,
                                        style: kfont22w_400black(),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "กาแฟ",
                                        overflow: TextOverflow.ellipsis,
                                        style: kfontH3InterBlackColor(),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  width: 100,
                                  child: Text(
                                    formatPrice("100000"),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: kfontH1InterBoldBlackColor(),
                                  ),
                                ),
                                ReorderableDragStartListener(
                                  key: ValueKey(item),
                                  index: index,
                                  child: Container(
                                    height: 100,
                                    width: 50,
                                    // color: Colors.red,
                                    child: const Icon(
                                      Icons.reorder_outlined,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatPrice(String price) {
    if (price.isNotEmpty) {
      int parsedPrice = int.tryParse(price) ?? 0;
      return NumberFormat.decimalPattern().format(parsedPrice);
    }
    return '';
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 8, animValue)!;
        return Material(
          elevation: elevation,
          child: child,
        );
      },
      child: child,
    );
  }

  Widget searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        width: 100,
        height: 100,
        child: TextFormField(
          style: kfontH2InterBlackColor(),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              key: const Key(
                "microphone",
              ),
              onPressed: () {
                // print("Clicking mic icon");
              },
              icon: const Icon(
                Icons.mic,
                size: 30,
              ),
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 40,
            ),
            border: InputBorder.none,
            hintText: 'Menu Name...',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),
          onChanged: (value) {
            setState(
              () {
                // searchText.text = value;
                // _searchViewModel.onUserSearchItemFilter(searchText.text);
              },
            );
          },
        ),
      ),
    );
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      // Perform the actual submission logic here
      // For example, you can save the menu information to a list
      // or send it to a backend server.

      // Menu details
      String menuName = nameMenu.text;
      String menuPrice = priceMenu.text;
      String menuCategory = categoryMenu.text;

      // Assuming you have a class to represent a menu item
      // Menu newItem = Menu(
      //   name: menuName,
      //   price: menuPrice,
      //   category: menuCategory,
      //   imagePath: _file.path, // Assuming you want to store the image path
      // );

      // Add the new menu item to your list or perform any other action
      // based on your requirements.
      // For example:
      setState(() {
        _itSkills.add(menuName);
      });

      // Close the dialog
      Navigator.of(context).pop();
    }
  }

  uploadImage(StateSetter setStateDialog) async {
    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var selected = File(image.path);

        setStateDialog(() {
          _file = selected;
        });
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
        setStateDialog(() {
          _file = File(image.path);
          webImage = f;
        });
      } else {
        Utility.toastMessage("ERROR_MESSAGE.PLEASE_SELECT_IMAGE".tr());
      }
    } else {
      Utility.toastMessage("ERROR_MESSAGE.PERMISSION_NOT_GRANTED".tr());
    }
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (returnedImage != null) _file = File(returnedImage.path);
    });
    print(returnedImage!.path);
  }

  Future pickImageFromCamera(
      {required ImagePicker imagePicker, required File? selectedImage}) async {
    final returnedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }
}
