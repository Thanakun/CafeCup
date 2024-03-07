import 'dart:io';
import 'dart:ui';

import 'package:coffee_application/model/menu.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/provider/shop_provider.dart';
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
import 'package:provider/provider.dart';

class AllMenuShopPage extends StatefulWidget {
  const AllMenuShopPage({
    required this.shop,
    super.key,
  });

  final ShopModel shop;

  @override
  State<AllMenuShopPage> createState() => _AllMenuShopPageState();
}

class _AllMenuShopPageState extends State<AllMenuShopPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile _file = XFile("Empty");
  Uint8List webImage = Uint8List(10);

  TextEditingController nameMenu = TextEditingController();
  TextEditingController priceMenu = TextEditingController();
  TextEditingController categoryMenu = TextEditingController();

  TextEditingController searchText = TextEditingController();
  late List<Menus> _filteredMenus;
  @override
  void initState() {
    super.initState();
    _filteredMenus = widget.shop.menus!;
  }

  List<Menus> menuAddingImage = [];

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
                                            ? FutureBuilder(
                                                future: (_xfileToUnit8(_file)),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return _imageContainerForEmptyImage();
                                                  } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return _imageContainerForEmptyImage();
                                                  } else if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done &&
                                                      snapshot.data != null) {
                                                    return Image.memory(
                                                      snapshot.data!,
                                                    );
                                                  }
                                                  return Container();
                                                },
                                              )
                                            : Image.file(File(_file.path)),
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
                                keyboardType: TextInputType.number,
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
                                style: kfontH2InterBlackColor(),
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    errorStyle: kfont22_400ErrorStyle(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    constraints:
                                        const BoxConstraints(minHeight: 100),
                                    labelText:
                                        "ALL_SHOP_MENU.LABEL.CATEGORY".tr(),
                                    labelStyle:
                                        kfontH1InterBlackColorHalfOpacity(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintStyle: kfontH2InterBlackColor()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'ALL_SHOP_MENU.VALIDATOR_FIELD.CATEGORY'
                                        .tr();
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
                                            "BUTTON.BUTTON_SAVE".tr(),
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
                    child: ListView.builder(
                      // buildDefaultDragHandles: false,
                      // onReorder: (oldIndex, newIndex) {
                      //   setState(() {
                      //     if (oldIndex < newIndex) {
                      //       newIndex -= 1;
                      //     }
                      //     final Menus item = context
                      //         .read<ShopProvider>()
                      //         .removeMenuAt(oldIndex);

                      //     context
                      //         .read<ShopProvider>()
                      //         .insertMenuItem(newIndex, item);
                      //   });
                      // },
                      shrinkWrap: true,
                      itemCount: _filteredMenus.length,
                      itemBuilder: (context, index) {
                        late Menus item;
                        item = _filteredMenus[index];
                        return Dismissible(
                          key: ValueKey(item),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              widget.shop.menus!.removeAt(index);
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
                                _imageContainerForImageFile(
                                  imageFileToDisplay: XFile(item.image!),
                                ),
                                sectionBufferWidth(bufferSection: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 150,
                                      child: Text(
                                        item.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: kfont22w_400black(),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        item.category!,
                                        overflow: TextOverflow.ellipsis,
                                        style: kfontH3InterBlackColor(),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  margin: EdgeInsets.only(right: width * 0.05),
                                  child: Text(
                                    formatPrice(item.price!.toString()),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: kfontH1InterBoldBlackColor(),
                                  ),
                                ),
                                // ReorderableDragStartListener(
                                //   key: ValueKey(item),
                                //   index: index,
                                //   child: Container(
                                //     height: 100,
                                //     width: 50,
                                //     // color: Colors.red,
                                //     child: const Icon(
                                //       Icons.delete,
                                //       size: 20,
                                //     ),
                                //   ),
                                // ),
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

  Container _imageContainerForEmptyImage() {
    return Container(
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
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
    );
  }

  Container _imageContainerForImageFile({required XFile imageFileToDisplay}) {
    return Container(
      width: 100,
      height: 100,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: kIsWeb
          ? FutureBuilder(
              future: (_xfileToUnit8(imageFileToDisplay)),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return _imageContainerForEmptyImage();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return _imageContainerForEmptyImage();
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return Image.memory(
                    snapshot.data!,
                  );
                }
                return Container();
              },
            )
          : Image.file(File(imageFileToDisplay.path)),
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
                searchText.text = value;
                filterMenusByName(menu: widget.shop.menus!, query: value);
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
      Menus menu = Menus(
        name: nameMenu.text,
        price: int.parse(priceMenu.text),
        category: categoryMenu.text.toString(),
        description: "",
        image: _file.path,
      );

      setState(() {
        widget.shop.menus!.add(menu);
        menuAddingImage.add(menu);
        // context.read<ShopProvider>().addMenu(menu);
      });

      //clear
      _file = XFile("Empty");
      nameMenu.clear();
      priceMenu.clear();
      categoryMenu.clear();

      // Close the dialog
      Navigator.of(context).pop(menuAddingImage);
    }
  }

  Future<Uint8List> _xfileToUnit8(XFile file) async {
    var f = await file.readAsBytes();
    return f;
  }

  uploadImage(StateSetter setStateDialog) async {
    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        XFile selected = image;

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
          _file = image;
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
      if (returnedImage != null) _file = returnedImage;
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

  void filterMenusByName({required List<Menus> menu, required String query}) {
    // Update the list of filtered menus based on the name
    _filteredMenus = menu
        .where((menu) =>
            (menu.name!.toLowerCase().contains(query.toLowerCase())) ||
            (menu.category!.toLowerCase().contains(query.toLowerCase())) ||
            (menu.price.toString().contains(query)))
        .toList();
  }
}
