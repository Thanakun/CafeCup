import 'dart:io';

import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/viewmodel/add_editing_image_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:image_picker/image_picker.dart';

class AddEditingImagesShopList extends StatefulWidget {
  const AddEditingImagesShopList(
      {super.key,
      required this.shop,
      required this.callBackFunction,
      required this.isHaveShopAlready});

  final VoidCallback callBackFunction;
  final ShopModel shop;
  final bool isHaveShopAlready;

  @override
  State<AddEditingImagesShopList> createState() =>
      _AddEditingImagesShopListState();
}

class _AddEditingImagesShopListState extends State<AddEditingImagesShopList> {
  final int _maximumImagesAddingPossible = 5;

  ImagePicker _imagePicker = ImagePicker();
  List<XFile>? _shopImagesFileList = [];

  late final AddEditImageVM _vm;

  bool isShopImage = false;
  bool isFoodImage = false;
  bool isMenuImage = false;
  bool isOtherImage = false;

  @override
  void initState() {
    super.initState();
    _vm = AddEditImageVM();
  }

  @override
  void dispose() {
    super.dispose();
    isFoodImage = false;
    isMenuImage = false;
    isOtherImage = false;
    isShopImage = false;
  }

  Map<String, List<String>> mapImage = {
    "shopImages": [],
    "foodImages": [],
    "menuImages": [],
    "otherImages": [],
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'รูปภาพของร้านค้า',
            style: kfontH1InterBoldBlackColor(),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              widget.callBackFunction();
              Navigator.of(context).pop(mapImage);
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImagePath), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: width,
                  height: height,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _titleSection(
                            title:
                                "รูปภาพร้าน (${widget.shop.shopImage == null ? 1 : widget.shop.shopImage!.length} / $_maximumImagesAddingPossible )",
                            toInsertImageList: widget.shop.shopImage ?? [],
                            isEdit: isShopImage,
                            onTap: () {
                              selectImage(widget.shop.shopImage!, isShopImage,
                                      "shopImages")
                                  .then((value) {
                                setState(() {
                                  isShopImage = true;
                                });
                              });
                            }),
                        _imageListCarousel(
                            listOfImages: widget.shop.shopImage ?? [],
                            shop: widget.shop,
                            isEdit: isShopImage,
                            objectName: "shopimages",
                            onTap: () {
                              selectImage(widget.shop.shopImage!, isShopImage,
                                      "shopImages")
                                  .then((value) {
                                setState(() {
                                  isShopImage = true;
                                });
                              });
                            }),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        _titleSection(
                            title:
                                "รูปภาพเมนู(${widget.shop.menuImages == null ? 1 : widget.shop.menuImages!.length} / $_maximumImagesAddingPossible )",
                            toInsertImageList: widget.shop.menuImages ?? [],
                            isEdit: isMenuImage,
                            onTap: () {
                              selectImage(widget.shop.menuImages!, isMenuImage,
                                      "menuImages")
                                  .then((value) {
                                setState(() {
                                  isMenuImage = true;
                                });
                              });
                            }),
                        _imageListCarousel(
                            listOfImages: widget.shop.menuImages ?? [],
                            shop: widget.shop,
                            isEdit: isMenuImage,
                            objectName: "menuimages",
                            onTap: () {
                              selectImage(widget.shop.menuImages!, isMenuImage,
                                      "menuImages")
                                  .then((value) {
                                setState(() {
                                  isMenuImage = true;
                                });
                              });
                            }),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        _titleSection(
                            title:
                                "รูปภาพอาหาร (${widget.shop.foodImages == null ? 1 : widget.shop.foodImages!.length} / $_maximumImagesAddingPossible  )",
                            toInsertImageList: widget.shop.foodImages ?? [],
                            isEdit: isFoodImage,
                            onTap: () {
                              selectImage(widget.shop.foodImages!, isFoodImage,
                                      "foodImages")
                                  .then((value) {
                                setState(() {
                                  isFoodImage = true;
                                });
                              });
                            }),
                        _imageListCarousel(
                            listOfImages: widget.shop.foodImages ?? [],
                            shop: widget.shop,
                            isEdit: isFoodImage,
                            objectName: "foodimages",
                            onTap: () {
                              setState(() {
                                selectImage(widget.shop.foodImages!,
                                        isFoodImage, "foodImages")
                                    .then((value) {
                                  setState(() {
                                    isFoodImage = true;
                                  });
                                });
                              });
                            }),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        _titleSection(
                          title:
                              "รูปภาพอื่นๆ (${widget.shop.otherImages == null ? 1 : widget.shop.otherImages!.length} / $_maximumImagesAddingPossible )",
                          toInsertImageList: widget.shop.otherImages ?? [],
                          isEdit: isOtherImage,
                          onTap: () {
                            selectImage(widget.shop.otherImages!, isOtherImage,
                                    "otherImages")
                                .then(
                              (value) {
                                setState(
                                  () {
                                    isOtherImage = true;
                                  },
                                );
                              },
                            );
                          },
                        ),
                        _imageListCarousel(
                          listOfImages: widget.shop.otherImages ?? [],
                          shop: widget.shop,
                          isEdit: isOtherImage,
                          objectName: "otherimages",
                          onTap: () {
                            setState(
                              () {
                                selectImage(widget.shop.otherImages!,
                                        isOtherImage, "otherImages")
                                    .then(
                                  (value) {
                                    setState(
                                      () {
                                        isOtherImage = true;
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        sectionBufferHeight(bufferSection: height * 0.015),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  Row _titleSection(
      {required String title,
      required List<String> toInsertImageList,
      required bool isEdit,
      required Function onTap}) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: kfontH1InterBoldBlackColor(),
          ),
        ),
        const Spacer(),
        toInsertImageList.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  onTap();
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "แก้ไขรูปภาพ",
                    style: kfontH2InterBlackColorHalfOpacity(),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  GridView _imageListCarousel(
      {required List<String>? listOfImages,
      required ShopModel shop,
      required bool isEdit,
      required String objectName,
      required Function onTap}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          crossAxisCount: 3,
          childAspectRatio: 0.8),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: listOfImages!.isEmpty ? 1 : listOfImages.length,
      itemBuilder: (context, index) {
        return listOfImages.isEmpty
            ? GestureDetector(
                onTap: () {
                  onTap();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: brownBorderButton),
                    color: backGroundButton,
                  ),
                  width: 90,
                  height: 90,
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
                width: 500,
                height: 500,
                decoration: kdecorationForContainerActiveItem,
                child: FittedBox(
                  child: isEdit
                      ? kIsWeb
                          ? FutureBuilder(
                              future:
                                  (_xfileToUnit8(XFile(listOfImages[index]))),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text(
                                          "ERROR_MESSAGE.ERROR_LOADING_FAIL")
                                      .tr();
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.data != null) {
                                  return Image.memory(
                                    snapshot.data!,
                                  );
                                }
                                return Container();
                              },
                            )
                          : Image.file(File(listOfImages[index]))
                      : FutureBuilder(
                          future: _vm.shopGetMenuImageFromMinio(
                              shop: shop,
                              objectName: objectName,
                              maxImageLength: listOfImages.length),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("ERROR_MESSAGE.ERROR_LOADING_FAIL")
                                  .tr();
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return snapshot.data!.isNotEmpty
                                  ? FadeInImage(
                                      image:
                                          NetworkImage(snapshot.data![index]),
                                      fit: BoxFit.cover,
                                      placeholder: AssetImage(imageNotFound))
                                  : Image.asset(imageNotFound);
                            }
                            return Container();
                          },
                        ),
                ),
              );
      },
    );
  }

  Future<Uint8List> _xfileToUnit8(XFile file) async {
    var f = await file.readAsBytes();
    return f;
  }

  Future selectImage(
      List<String> givenListImages, bool isEdit, String imageType) async {
    final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
    if (givenListImages.isNotEmpty) {
      givenListImages.clear();

      for (int i = 0; i < selectedImages.length; i++) {
        if (i < 5) {
          givenListImages.add(selectedImages[i].path);
        }
      }
    } else if (givenListImages.isEmpty) {
      for (int i = 0; i < selectedImages.length; i++) {
        if (i < 5) {
          givenListImages.add(selectedImages[i].path);
        }
      }
    } else {
      givenListImages.clear();
    }

    setState(() {});
    mapImage[imageType] = givenListImages;
    isEdit = true;
  }
}
