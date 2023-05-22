import 'package:flutter/material.dart';

const Color kRedButton = Color.fromRGBO(237, 98, 98, 1);

const Color kPinkInactiveColor = Color.fromRGBO(252, 208, 208, 1);

const Color kGreyUnSelectedButton = Color.fromRGBO(217, 217, 217, 1);

const Color kYellowSelectedButton = Color.fromRGBO(245, 224, 114, 1);

TextStyle font_h1() => const TextStyle(
    fontSize: 40,
    color: Colors.black,
    fontFamily: "THSarabun",
    fontWeight: FontWeight.bold);

TextStyle kfontH1InterBlackColor() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black);

TextStyle kfontH2InterBlackColor() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black);

TextStyle kfontH3InterBlackColor() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 0, 0, 0));

TextStyle kfontH4InterBlackColor() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 0, 0, 0));

TextStyle kfontH1InterWhiteColor() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH2InterWhiteColor() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH3InterWhiteColor() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH4InterWhiteColor() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white);

TextStyle kfontH1InterBlackColorHalfOpacity() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH2InterBlackColorHalfOpacity() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH3InterBlackColorHalfOpacity() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(0, 0, 0, 0.5));

TextStyle kfontH4InterBlackColorHalfOpacity() => const TextStyle(
    fontFamily: "Inter",
    fontSize: 14,
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
