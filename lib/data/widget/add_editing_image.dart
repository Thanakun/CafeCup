import 'package:flutter/material.dart';
import 'package:flutter_application_1/utility/my_constant.dart';
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
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "รูปภาพร้าน (${widget.listOfImagesOne.length} / ${_maximumImagesAddingPossible} )",
                                style: kfontH1InterBoldBlackColor(),
                              ),
                            ),
                            const Spacer(),
                            widget.listOfImagesOne.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      selectImage(widget.listOfImagesOne);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 30),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "แก้ไขรูปภาพ",
                                        style:
                                            kfontH2InterBlackColorHalfOpacity(),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  crossAxisCount: 3,
                                  childAspectRatio: 1),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget.listOfImagesOne.isEmpty
                              ? 1
                              : widget.listOfImagesOne.length,
                          itemBuilder: (context, index) {
                            return widget.listOfImagesOne.isEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      selectImage(widget.listOfImagesOne);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: brownBorderButton),
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
                                    margin: EdgeInsets.all(16),
                                    width: 250,
                                    height: 150,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(
                                          widget.listOfImagesOne[index].path),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
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
