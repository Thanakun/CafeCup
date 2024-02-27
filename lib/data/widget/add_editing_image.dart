import 'dart:io';

import 'package:coffee_application/utility/decoration.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:image_picker/image_picker.dart';

class AddEditingImagesList extends StatefulWidget {
  const AddEditingImagesList(
      {super.key,
      required this.listOfImagesOne,
      required this.listOfImagesTwo,
      required this.listOfImagesThree,
      required this.listOfImagesFour,
      required this.callBackFunction});

  final VoidCallback callBackFunction;
  final List<XFile> listOfImagesOne;
  final List<XFile> listOfImagesTwo;
  final List<XFile> listOfImagesThree;
  final List<XFile> listOfImagesFour;

  @override
  State<AddEditingImagesList> createState() => _AddEditingImagesListState();
}

class _AddEditingImagesListState extends State<AddEditingImagesList> {
  final int _maximumImagesAddingPossible = 5;

  ImagePicker _imagePicker = ImagePicker();
  List<XFile>? _shopImagesFileList = [];

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
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              widget.callBackFunction();
              Navigator.of(context).pop();
              print("hello word");
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
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
                                "รูปภาพร้าน (${widget.listOfImagesOne.length} / $_maximumImagesAddingPossible )",
                            toInsertImageList: widget.listOfImagesOne),
                        _imageListCarousel(
                            listOfImages: widget.listOfImagesOne),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        _titleSection(
                            title:
                                "รูปภาพเมนู(${widget.listOfImagesTwo.length} / $_maximumImagesAddingPossible )",
                            toInsertImageList: widget.listOfImagesTwo),
                        _imageListCarousel(
                            listOfImages: widget.listOfImagesTwo),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        _titleSection(
                            title:
                                "รูปภาพอาหาร (${widget.listOfImagesThree.length} / $_maximumImagesAddingPossible )",
                            toInsertImageList: widget.listOfImagesThree),
                        _imageListCarousel(
                            listOfImages: widget.listOfImagesThree),
                        sectionBufferHeight(bufferSection: height * 0.015),
                        _titleSection(
                            title:
                                "รูปภาพอื่นๆ (${widget.listOfImagesFour.length} / $_maximumImagesAddingPossible )",
                            toInsertImageList: widget.listOfImagesFour),
                        _imageListCarousel(
                            listOfImages: widget.listOfImagesFour),
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
      {required String title, required List<XFile> toInsertImageList}) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 30),
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
                  selectImage(toInsertImageList);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
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

  GridView _imageListCarousel({required List<XFile>? listOfImages}) {
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
                  selectImage(listOfImages);
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
                  child: Image.file(File(listOfImages[index].path)),
                ),
              );
      },
    );
  }

  void selectImage(List givenListImages) async {
    final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
    if (givenListImages.isNotEmpty) {
      givenListImages.clear();

      givenListImages.addAll(selectedImages.take(5));
    } else if (givenListImages.isEmpty) {
      givenListImages.addAll(selectedImages.take(5));
    } else {
      givenListImages.clear();
    }
    print(givenListImages.length);
    setState(() {});
  }
}
