import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String backgroundImagePath = "images/cafe_background.jpg";

const Color kRedButton = Color.fromRGBO(237, 98, 98, 1);

const Color kPinkInactiveColor = Color.fromRGBO(252, 208, 208, 1);

const Color kGreyUnSelectedButton = Color.fromRGBO(217, 217, 217, 1);

const Color kYellowSelectedButton = Color.fromRGBO(245, 224, 114, 1);

const Color supV4 = Color.fromRGBO(241, 199, 98, 1);

const Color sup1V5 = Color.fromRGBO(226, 199, 153, 1);

const Color main1V4 = Color.fromRGBO(185, 148, 112, 1);

const Color sup3V4 = Color.fromRGBO(135, 206, 48, 1);

const Color borderButton = Color.fromRGBO(192, 130, 97, 1);

const Color backGroundButton = Color.fromRGBO(244, 234, 222, 1);

const Color colorAcceptButton = Color.fromRGBO(135, 206, 48, 1);

const Color backGroundApplication = Color.fromRGBO(255, 245, 233, 1);

TextStyle kfontH0InterBlackColor() => const TextStyle(
    fontSize: 32,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontFamily: "OpenSans",
    fontWeight: FontWeight.bold);

TextStyle kfontH1InterBlackColor() => const TextStyle(
    fontFamily: "OpenSans",
    fontStyle: FontStyle.normal,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black);

TextStyle kfontH1InterWhiteColor() => const TextStyle(
    fontFamily: "OpenSans",
    fontStyle: FontStyle.normal,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH2InterBlackColor() => const TextStyle(
    fontFamily: "OpenSans",
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.black);

TextStyle kfontH3InterBlackColor() => const TextStyle(
    fontFamily: "OpenSans",
    fontStyle: FontStyle.normal,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 0, 0, 0));

TextStyle kfontH4InterBlackColor() => const TextStyle(
    fontFamily: "OpenSans",
    fontStyle: FontStyle.normal,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: const Color.fromARGB(255, 0, 0, 0));

// TextStyle kfontH1InterWhiteColor() => const TextStyle(
//     fontFamily: "OpenSans",
//     fontSize: 20,
//     fontStyle: FontStyle.normal,
//     fontWeight: FontWeight.bold,
//     color: Colors.white);

TextStyle kfontH2InterWhiteColor() => const TextStyle(
    fontFamily: "OpenSans",
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH3InterWhiteColor() => const TextStyle(
    fontFamily: "OpenSans",
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH4InterWhiteColor() => const TextStyle(
    fontFamily: "OpenSans",
    fontStyle: FontStyle.normal,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH1InterBlackColorHalfOpacity() => const TextStyle(
    fontFamily: "OpenSans",
    fontStyle: FontStyle.normal,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH2InterBlackColorHalfOpacity() => const TextStyle(
    fontFamily: "OpenSans",
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH2InterNormalBlackColorHalfOpacity() => const TextStyle(
    fontFamily: "OpenSans",
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH3InterBlackColorHalfOpacity() => const TextStyle(
    fontFamily: "OpenSans",
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH4InterBlackColorHalfOpacity() => const TextStyle(
    fontFamily: "OpenSans",
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

class Utility {
  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
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
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
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
