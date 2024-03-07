import 'dart:io';

import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/viewmodel/add_editing_image_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:image_picker/image_picker.dart';

class AddEditingImagesList extends StatefulWidget {
  const AddEditingImagesList(
      {super.key,
      required this.shop,
      required this.callBackFunction,
      required this.isHaveShopAlready});

  final VoidCallback callBackFunction;
  final ShopModel shop;
  final bool isHaveShopAlready;

  @override
  State<AddEditingImagesList> createState() => _AddEditingImagesListState();
}

class _AddEditingImagesListState extends State<AddEditingImagesList> {
  final int _maximumImagesAddingPossible = 5;

  ImagePicker _imagePicker = ImagePicker();
  List<XFile>? _shopImagesFileList = [];

  late final AddEditImageVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = AddEditImageVM();
  }

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
              Navigator.of(context).pop();
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
                            toInsertImageList: widget.shop.shopImage ?? []),
                        _imageListCarousel(
                            listOfImages: widget.shop.shopImage ?? [],
                            shop: widget.shop),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        _titleSection(
                            title:
                                "รูปภาพเมนู(${widget.shop.menuImages == null ? 1 : widget.shop.menuImages!.length} / $_maximumImagesAddingPossible )",
                            toInsertImageList: widget.shop.menuImages ?? []),
                        _imageListCarousel(
                            listOfImages: widget.shop.menuImages ?? [],
                            shop: widget.shop),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        _titleSection(
                            title:
                                "รูปภาพอาหาร (${widget.shop.foodImages == null ? 1 : widget.shop.foodImages!.length} / $_maximumImagesAddingPossible  )",
                            toInsertImageList: widget.shop.foodImages ?? []),
                        _imageListCarousel(
                            listOfImages: widget.shop.foodImages ?? [],
                            shop: widget.shop),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        _titleSection(
                            title:
                                "รูปภาพอื่นๆ (${widget.shop.otherImages == null ? 1 : widget.shop.otherImages!.length} / $_maximumImagesAddingPossible )",
                            toInsertImageList: widget.shop.otherImages ?? []),
                        _imageListCarousel(
                            listOfImages: widget.shop.otherImages ?? [],
                            shop: widget.shop),
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
      {required String title, required List<String> toInsertImageList}) {
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
                  setState(() {
                    selectImage(toInsertImageList);
                  });
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
      {required List<String>? listOfImages, required ShopModel shop}) {
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
                  setState(() {
                    selectImage(listOfImages);
                  });
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
                  child: kIsWeb
                      ? FutureBuilder(
                          future: (_xfileToUnit8(XFile(listOfImages[index]))),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("ERROR_MESSAGE.ERROR_LOADING_FAIL")
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
                      : Image.file(File(listOfImages[index])),
                ),
              );
      },
    );
  }

  Future<Uint8List> _xfileToUnit8(XFile file) async {
    var f = await file.readAsBytes();
    return f;
  }

  void selectImage(List<String> givenListImages) async {
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
    print(givenListImages.length);
    setState(() {});
  }
}
