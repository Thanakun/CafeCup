import 'package:coffee_application/screen/my_component/barcode_scanner_overlay_shape.dart';
import 'package:coffee_application/screen/my_component/buttom_navigationbar_shop.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerCodePage extends StatefulWidget {
  const ScannerCodePage({super.key});

  @override
  State<ScannerCodePage> createState() => _ScannerCodePageState();
}

class _ScannerCodePageState extends State<ScannerCodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Barcode');
  final TextEditingController inputStr = TextEditingController();
  late QRViewController controller;
  late String? barcode;
  bool _isScanningTime = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 40, color: Colors.black),
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: width,
                height: height,
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.07281, vertical: height * 0.0163),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.8,
                      height: width * 0.8,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Indexer(
                        children: <Widget>[
                          _cameraBox(),
                          _focusBox(width: width),
                          _borderBox(),
                          _pipeBox(width: width),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: inputStr,
                      style: kfont26_400(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          constraints:
                              BoxConstraints(maxWidth: width, maxHeight: 100)),
                    ),
                    InkWell(
                      splashColor: Colors.greenAccent,
                      onTap: () {
                        //TODO Use Code
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
                          // Your logic here
                          print("hello");

                          // print(nameShop.text);
                          // print(descriptionShop.text);
                          // print(selectedProvince);
                          // print(selectedDistrict);
                          // print(selectedSubDistrict);
                          // print(addressDetail.text);
                          // Navigator.push(
                          //     (context),
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const ShopRegisterSecondView(),
                          //     ));
                          // Add more logic as needed
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: height*0.01),
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        width: width*0.5,
                        height: constraints.maxHeight * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Center(
                          child: Text(
                            "NEXT PAGE",
                            style: kfontH1InterBoldBlackColor(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Indexed _borderBox() {
    return Indexed(
      index: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            color: Colors.black87,
            width: 2,
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }

  Indexed _pipeBox({required width}) {
    return Indexed(
      index: 2,
      child: Center(
          child: Container(
        color: Colors.red,
        height: width * 0.78,
        width: width * 0.003,
      )),
    );
  }

  Indexed _cameraBox() {
    return Indexed(
      index: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: QRView(
          key: qrKey,
          cameraFacing: CameraFacing.back,
          formatsAllowed: const [
            BarcodeFormat.code128,
            BarcodeFormat.ean8,
            BarcodeFormat.ean13
          ],
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen(
      (scanData) async {
        setState(() {});
        if (!_isScanningTime) {
          _isScanningTime = true;
          controller.pauseCamera();
          inputStr.text = scanData.code!;
          //TODO onUserScanbarcode
          try {
            // await _viewModel.onUserScannedBarcode(
            //   barcode: barcode.toString(),
            // );
            _isScanningTime = false;
            controller.resumeCamera();
            // } on ProductRunOutOfStockError catch (_) {
            //   await _alertRunOutOfBox();
            // } on ResourceNotFoundError catch (_) {
            //   await _alertNotSpecifyBox();
          } catch (e) {
            //TODO: Handle general exceptions
          }
        }
      },
    );
  }

  Indexed _focusBox({required width}) {
    return Indexed(
      index: 2,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Container(
            decoration: ShapeDecoration(
                shape: BarcodeScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 10,
              borderLength: 15,
              borderWidth: 5,
              cutOutSize: width * 0.55,
            )),
          ),
        ),
      ),
    );
  }
}
