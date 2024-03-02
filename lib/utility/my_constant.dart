import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String backgroundRegisterPath = "assets/images/register-background.png";
const String backgroundImagePath = "assets/images/cafe_background.jpg";
const String backgroundCustomerImagePath =
    "assets/images/customer-background.png";
const String backgroundCustomerHomeImagePath =
    "assets/images/customer-home.png";
const String backgroundShopInformationPath = "assets/images/owner_home.jpg";
const String shopCoverImagePath = "assets/images/shop_cover.png";
const String americanoImagePath = "assets/images/coffee_image.png";
const String barChartPath = "assets/images/bar_chart.jpg";
const String pieChartPath = "assets/images/pie_chart.png";
const String webChartPath = "assets/images/web_chart.png";
const String linearChartPath = "assets/images/linear_chart.png";
const String imageNotFound = "assets/images/image_not_found.png";

const Color kRedButton = Color.fromRGBO(237, 98, 98, 1);

const Color kPinkInactiveColor = Color.fromRGBO(252, 208, 208, 1);

const Color kGreyUnSelectedButton = Color.fromRGBO(217, 217, 217, 1);

const Color kYellowSelectedButton = Color.fromRGBO(245, 224, 114, 1);

const Color kYellowSelectedButtonSearchView = Color.fromRGBO(241, 199, 98, 1);

const Color kGreenUnSelectedButton = Color.fromRGBO(241, 199, 98, 1);

const Color backgroundActiveButton = Color.fromRGBO(226, 199, 153, 1);

const Color fontMenuNameColor = Color.fromRGBO(185, 148, 112, 1);

const Color sup3V4 = Color.fromRGBO(135, 206, 48, 1);

const Color selectButtonColor = Color.fromRGBO(223, 184, 127, 1);

const Color brownBorderButton = Color.fromRGBO(192, 130, 97, 1);

const Color backGroundButton = Color.fromRGBO(244, 234, 222, 1);

const Color kcolorAcceptButton = Color.fromRGBO(135, 206, 48, 1);

const Color backGroundApplication = Color.fromRGBO(255, 245, 233, 1);

const Color colorStarReviewUnSelect = Color.fromRGBO(169, 179, 136, 1);

const Color colorBackGroundNavBar = Color.fromRGBO(185, 148, 112, 1);

const Color colorBackGroundSearchBox = Color.fromRGBO(169, 179, 136, 1);

const Color colorRedBackGroundIcon = Color.fromRGBO(154, 59, 59, 1);

TextStyle kfontNameMenu() => const TextStyle(
      color: fontMenuNameColor,
      fontSize: 22,
      fontWeight: FontWeight.w400,
    );

TextStyle kfont22w_400black() => const TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w400,
    );

TextStyle kfontMenuDescription() => const TextStyle(
      color: Color(0xFF87CE30),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );

TextStyle kfontMenuPrice() => const TextStyle(
      color: Color(0xFFE2C799),
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

TextStyle kfont32_400() => const TextStyle(
      fontSize: 32,
      color: Colors.black,
      fontStyle: FontStyle.normal,
    );

TextStyle kfontH0InterBlackColor() => const TextStyle(
    fontSize: 32,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

TextStyle kfontH0InterWhiteColor() => const TextStyle(
    fontSize: 32,
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

TextStyle kfont26_400() => const TextStyle(
    fontSize: 26,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400);

TextStyle kfont26Bold_400() => const TextStyle(
    fontSize: 26,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold);

TextStyle kfont22_400ErrorStyle() => const TextStyle(
    fontSize: 22,
    color: Colors.red,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400);

TextStyle kfontH1Inter_400BlackColor() => const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black);

TextStyle kfontH1InterBoldBlackColor() => const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black);

TextStyle kfontH1InterBoldWhiteColor() => const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH1InterWhiteColor() => const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH2InterBlackColor() => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: Colors.black);

TextStyle kfontH2InterBoldBlackColor() => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.black);

TextStyle kfontH2InterBoldWhiteColor() => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.white);

TextStyle kfontH3InterBlackColor() => const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color.fromARGB(255, 0, 0, 0));

TextStyle kfontH4InterBlackColor() => const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: const Color.fromARGB(255, 0, 0, 0));

TextStyle kfontH5InterBlackColor() => const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: const Color.fromARGB(255, 0, 0, 0));

// TextStyle kfontH1InterWhiteColor() => const TextStyle(
//
//     fontSize: 20,
//     fontStyle: FontStyle.normal,
//     fontWeight: FontWeight.bold,
//     color: Colors.white);

TextStyle kfontH2InterWhiteColor() => const TextStyle(
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH3InterWhiteColor() => const TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH4InterWhiteColor() => const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH1InterBlackColorHalfOpacity() => const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH2InterBlackColorHalfOpacity() => const TextStyle(
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH2GreyColorHalfOpacity() => const TextStyle(
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(77, 75, 75, 1));

TextStyle kfontH2InterNormalBlackColorHalfOpacity() => const TextStyle(
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH3InterBlackColorHalfOpacity() => const TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH4InterBlackColorHalfOpacity() => const TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

SizedBox sectionBufferHeight({double bufferSection = 8}) {
  return SizedBox(
    height: bufferSection,
  );
}

SizedBox sectionBufferWidth({double bufferSection = 8}) {
  return SizedBox(
    width: bufferSection,
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

class Utility {
  static toastMessage(String message) {
    Fluttertoast.showToast(
        fontSize: 24,
        msg: message,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        webPosition: "center",
        webBgColor: "linear-gradient(to top, #FE6000, #FD5000)");
  }

  static void flushBarErrorMessage(
      {required String message, required BuildContext context}) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          message: message,
          borderRadius: BorderRadius.circular(8),
          duration: const Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(Icons.error, size: 28, color: Colors.white),
        )..show(context));
  }

  static void flushBarGrantedMessage(
      {required String message, required BuildContext context}) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          message: message,
          borderRadius: BorderRadius.circular(8),
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.green,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(Icons.error, size: 28, color: Colors.white),
        )..show(context));
  }

  static snackBarError(
      {required String message, required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
