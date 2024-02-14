// ignore_for_file: prefer_is_empty

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Helper {
  static List<Map<String, dynamic>> selectMonthList = [
    {
      "id": 1,
      "monthNameTh": "มกราคม",
      "monthNameEng": "January",
    },
    {
      "id": 2,
      "monthNameTh": "กุมภาพันธ์",
      "monthNameEng": "February",
    },
    {
      "id": 3,
      "monthNameTh": "มีนาคม",
      "monthNameEng": "March",
    },
    {
      "id": 4,
      "monthNameTh": "เมษายน",
      "monthNameEng": "April",
    },
    {
      "id": 5,
      "monthNameTh": "พฤษภาคม",
      "monthNameEng": "May",
    },
    {
      "id": 6,
      "monthNameTh": "มิถุนายน",
      "monthNameEng": "June",
    },
    {
      "id": 7,
      "monthNameTh": "กรกฎาคม",
      "monthNameEng": "July",
    },
    {
      "id": 8,
      "monthNameTh": "สิงหาคม",
      "monthNameEng": "August",
    },
    {
      "id": 9,
      "monthNameTh": "กันยายน",
      "monthNameEng": "September",
    },
    {
      "id": 10,
      "monthNameTh": "ตุลาคม",
      "monthNameEng": "October",
    },
    {
      "id": 11,
      "monthNameTh": "พฤศจิกายน",
      "monthNameEng": "November",
    },
    {
      "id": 12,
      "monthNameTh": "ธันวาคม",
      "monthNameEng": "December",
    },
  ];

  static List<Map<String, dynamic>> selectDataDateTypeList = [
    {
      "id": 1,
      "dataDateTypeTh": "ตลอดกาล",
      "dataDateTypeEng": "All Time",
    },
    {
      "id": 2,
      "dataDateTypeTh": "ไตรมาส",
      "dataDateTypeEng": "Quarter",
    },
    {
      "id": 3,
      "dataDateTypeTh": "ปี",
      "dataDateTypeEng": "Year",
    },
    {
      "id": 4,
      "dataDateTypeTh": "เดือน",
      "dataDateTypeEng": "Month",
    },
  ];

  static List<String> listOfYear = [
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
  ];

  static List<Map<String, dynamic>> listOfQuarter = [
    {
      "id": 1,
      "quarterTh": "ไตรมาสที่ 1",
      "quarterEng": "Q1",
    },
    {
      "id": 2,
      "quarterTh": "ไตรมาสที่ 2",
      "quarterEng": "Q2",
    },
    {
      "id": 3,
      "quarterTh": "ไตรมาสที่ 3",
      "quarterEng": "Q3",
    },
    {
      "id": 4,
      "quarterTh": "ไตรมาสที่ 4",
      "quarterEng": "Q4",
    },
  ];

  static String getQuarterNameById(int quarterId, bool isThai) {
    final String key = isThai ? 'quarterTh' : 'quarterEng';

    final Map<String, dynamic> quarter = listOfQuarter.firstWhere(
      (element) => element['id'] == quarterId,
      orElse: () => {
        "id": -1,
        "quarterTh": "ไม่พบข้อมูล",
        "quarterEng": "Not Found",
      },
    );

    return quarter["id"] != -1 ? quarter["key"] : -1;
  }

  static List<Map<String, dynamic>> listDateInWeek = [
    {
      "id": 1,
      "dayOfWeekTh": "วันอาทิตย์",
      "dayOfWeekEng": "Sunday",
    },
    {
      "id": 2,
      "dayOfWeekTh": "วันจันทร์",
      "dayOfWeekEng": "Monday",
    },
    {
      "id": 3,
      "dayOfWeekTh": "วันอังคาร",
      "dayOfWeekEng": "Tuesday",
    },
    {
      "id": 4,
      "dayOfWeekTh": "วันพุธ",
      "dayOfWeekEng": "Wednesday",
    },
    {
      "id": 5,
      "dayOfWeekTh": "วันพฤหัสบดี",
      "dayOfWeekEng": "Thursday",
    },
    {
      "id": 6,
      "dayOfWeekTh": "วันศุกร์",
      "dayOfWeekEng": "Friday",
    },
    {
      "id": 7,
      "dayOfWeekTh": "วันเสาร์",
      "dayOfWeekEng": "Saturday",
    },
  ];
  static String validateName(String value) {
    if (value.isEmpty) {
      return tr('VALIDATE.VALIDATE_NAME.EMPTY');
    } else if (value.length < 3) {
      return tr('VALIDATE.VALIDATE_NAME.TOO_SHORT');
    } else {
      return '';
    }
  }

  static String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return tr('VALIDATE.VALIDATE_MOBILE.EMPTY');
    } else if (!regExp.hasMatch(value)) {
      return tr('VALIDATE.VALIDATE_MOBILE.INVALID');
    }
    return '';
  }

  static String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return tr('VALIDATE.VALIDATE_EMAIL.EMPTY');
    } else if (!regex.hasMatch(value)) {
      return tr('VALIDATE.VALIDATE_EMAIL.INVALID');
    }
    return '';
  }

  static String? validatePrice(String? value) {
    String patttern = r'^\d{1,5}$'; // Regex pattern for 1 to 5 digits
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return tr('VALIDATE.VALIDATE_PRICE.EMPTY');
    } else if (!regExp.hasMatch(value)) {
      return tr('VALIDATE.VALIDATE_PRICE.INVALID');
    } else {
      int price = int.tryParse(value)!;
      if (price < 0 || price > 99999) {
        return tr('VALIDATE.VALIDATE_PRICE.OUT_OF_RANGE');
      }
    }
    return null; // Return null for successful validation
  }

  static String? validateUsername(String? username) {
    if (username == null ||username.isEmpty) {
      return tr('VALIDATE.VALIDATE_USERNAME.EMPTY');
    } else if (username.length < 5) {
      return tr('VALIDATE.VALIDATE_USERNAME.TOO_SHORT');
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return tr('VALIDATE.VALIDATE_USERNAME.INVALID_CHARACTERS');
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return tr('VALIDATE.VALIDATE_PASSWORD.EMPTY');
    } else if (password.length < 8) {
      return tr('VALIDATE.VALIDATE_PASSWORD.TOO_SHORT');
    } else {
      return null;
    }
  }

  static List<DropdownMenuItem<dynamic>> listToDropDownMenuItem(
      List<String> stringList) {
    List<DropdownMenuItem<dynamic>> dropdownItems =
        stringList.map((String value) {
      return DropdownMenuItem<dynamic>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return dropdownItems;
  }

  String getMonthNameById(int id, bool isThai) {
    List<Map<String, dynamic>> monthsList =
        isThai ? selectMonthList : selectMonthList;
    return monthsList.firstWhere(
        (month) => month["id"] == id)["monthName${isThai ? 'Th' : 'Eng'}"];
  }

  String getDataDateTypeById(int id, bool isThai) {
    List<Map<String, dynamic>> dataDateTypeList =
        isThai ? selectDataDateTypeList : selectDataDateTypeList;
    return dataDateTypeList.firstWhere((dataDateType) =>
        dataDateType["id"] == id)["dataDateType${isThai ? 'Th' : 'Eng'}"];
  }

  String getDayOfWeekById(int id, bool isThai) {
    List<Map<String, dynamic>> daysOfWeekList =
        isThai ? listDateInWeek : listDateInWeek;
    return daysOfWeekList.firstWhere((dayOfWeek) => dayOfWeek["id"] == id)[
        "dayOfWeek${isThai ? 'Th' : 'Eng'}"];
  }

  static int getMonthIdByNameTh(String monthNameTh) {
    final Map<String, dynamic> month = selectMonthList.firstWhere(
      (element) => element['monthNameTh'] == monthNameTh,
      orElse: () => {
        "id": -1,
        "monthNameTh": "ไม่พบ",
        "monthNameEng": "Not found",
      },
    );

    return month["id"] != -1 ? month['id'] : -1;
  }

  static int getMonthIdByName(String monthName, bool isThai) {
    final String key = isThai ? 'monthNameTh' : 'monthNameEng';

    final Map<String, dynamic> month = selectMonthList.firstWhere(
      (element) => element[key] == monthName,
      orElse: () => {
        "id": -1,
        "monthNameTh": "ไม่พบ",
        "monthNameEng": "Not found",
      },
    );

    return month["id"] != -1 ? month['id'] : -1;
  }

  static bool isThai(BuildContext context) =>
      Localizations.localeOf(context) == const Locale('th', 'TH');
}
