// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerBarcodeView extends StatefulWidget {
  const CustomerBarcodeView({
    Key? key,
    required this.codeString,
    required this.codeDetail,
    required this.dateExpired,
    required this.codeName,
  }) : super(key: key);

  final String codeString;
  final String codeDetail;
  final String dateExpired;
  final String codeName;

  @override
  State<CustomerBarcodeView> createState() => _CustomerBarcodeViewState();
}

class _CustomerBarcodeViewState extends State<CustomerBarcodeView> {
  bool isScannedByShop = false;
  // late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
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
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    top: height * 0.05,
                  ),
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BarcodeWidget(
                        barcode: Barcode.code128(),
                        data: widget.codeString,
                        width: constraints.maxWidth * 0.8,
                        height: constraints.maxHeight * 0.2,
                      ),
                      sectionBufferHeight(
                          bufferSection: constraints.maxHeight * 0.05),
                      BarcodeWidget(
                        barcode: Barcode.qrCode(),
                        data: widget.codeString,
                        width: constraints.maxWidth * 0.8,
                        height: constraints.maxHeight * 0.2,
                      ),
                      sectionBufferHeight(bufferSection: height * 0.05),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: brownBorderButton,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "CUSTOMER_BARCODE.BACK".tr(),
                          style: kfontH1InterBoldBlackColor(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void handleCodeBeingScanned(String scanData) {
    setState(() {
      isScannedByShop = true;
    });
    print("isScannedByShop");
    print(isScannedByShop);
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
}
