import 'dart:ui';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:coffee_application/model/response/spider_graph_response.dart';
import 'package:coffee_application/viewmodel/spider_chart_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/data/widget/sliver_multipleline_appbar.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shimmer/shimmer.dart';

class WebChartPage extends StatefulWidget {
  const WebChartPage({super.key});

  @override
  State<WebChartPage> createState() => _WebChartPageState();
}

class _WebChartPageState extends State<WebChartPage> {
  String selectedYearQuarter = "2024"; // Set a default year
  String selectedQuarter = "Q1"; // Set a default quarter

  String selectedYear = "2024"; // Set a default year

  String selectedYearMonth = "2024"; // Set a default year
  String selectMonthString = "DECEMBER";

  Map<String, dynamic> selectMonthList = {
    "JANUARY": 1,
    "FEBRUARY": 2,
    "MARCH": 3,
    "APRIL": 4,
    "MAY": 5,
    "JUNE": 6,
    "JULY": 7,
    "AUGUST": 8,
    "SEPTEMBER": 9,
    "OCTOBER": 10,
    "NOVEMBER": 11,
    "DECEMBER": 12
  };
  List<String> selectDataDateTypeList = [
    "All Time",
    "Quarter",
    "Year",
    "Month"
  ];
  String selectDateType = "All Time";
  List<String> listOfYear = [
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024"
  ];
  Map<String, int> listOfQuarter = {"Q1": 1, "Q2": 2, "Q3": 3, "Q4": 4};

  String selectDayOfWeek = "ALL";
  Map<String, dynamic> listDateInWeek = {
    "ALL": null,
    "SUN": 1,
    "MON": 2,
    "TUE": 3,
    "WED": 4,
    "THU": 5,
    "FRI": 6,
    "SAT": 7
  };

  String selectDateTypeFirst = "ALL Time";
  String selectDateTypeSecond = "ALL Time";

  double allTimeHeight = 0;
  bool isAddGraph = false;
  Map<int, bool> selectedGraph = {0: true, 1: false};

  final List<String> _graphOrdersList = ["Graph 1", "Graph 2"];
  String _selectGraph = "Graph 1";

  late final SpiderChartVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = SpiderChartVM();
    _vm.onUserEnterSpiderChartPage();
    selectDateTypeFirst =
        "${"CHART.FILTER.ALL_TIME".tr()} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
  }

  bool darkMode = false;
  bool useSides = true;
  double numberOfFeatures = 5;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(255, 245, 233, 1),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverMultilineAppBar(
              title: "CHART.WEB_CHART_PAGE.WEB_CHART_TITLE".tr(),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [Container()],
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. ${"CHART.TIME_RANGE_TITLE".tr()}",
                      style: kfontH2InterBlackColor(),
                    ),
                    sectionBufferHeight(),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () {
                              selectDateType = "All Time";
                              setState(() {
                                allTimeHeight = 100;

                                if (selectedGraph[0]!) {
                                  _vm.getSpiderChartFirstGraph(null, null, null,
                                      _getIndexDayOfWeek(selectDayOfWeek));
                                  selectDateTypeFirst =
                                      "${"CHART.FILTER.ALL_TIME".tr()} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                }
                                _vm.getSpiderChartSecondGraph(null, null, null,
                                    _getIndexDayOfWeek(selectDayOfWeek));
                                selectDateTypeSecond =
                                    "${"CHART.FILTER.ALL_TIME".tr()} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              height: allTimeHeight == 0 ? 100 : allTimeHeight,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectDateType == "All Time"
                                    ? selectButtonColor
                                    : null,
                              ),
                              foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectDateType == "All Time"
                                    ? null
                                    : selectButtonColor.withOpacity(0.4),
                              ),
                              child: Center(
                                child: Text(
                                  "CHART.FILTER.ALL_TIME".tr(),
                                  style: kfont22w_400black(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        sectionBufferWidth(bufferSection: 15),
                        Expanded(
                          flex: 6,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the tap for the "Quarter" section
                              selectDateType = "Quarter";

                              setState(() {
                                MapEntry<String, int>? matchingEntry =
                                    listOfQuarter.entries.firstWhere(
                                  (entry) => entry.key == selectedQuarter,
                                );
                                if (selectedGraph[0]!) {
                                  _vm.getSpiderChartFirstGraph(
                                      int.parse(selectedYearQuarter),
                                      matchingEntry.value,
                                      null,
                                      _getIndexDayOfWeek(selectDayOfWeek));
                                  selectDateTypeFirst =
                                      "${"CHART.FILTER.QUARTER".tr()} ${selectedQuarter} ปี ${selectedYearQuarter} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                  allTimeHeight = 100;
                                } else {
                                  _vm.getSpiderChartSecondGraph(
                                      int.parse(selectedYearQuarter),
                                      matchingEntry.value,
                                      null,
                                      _getIndexDayOfWeek(selectDayOfWeek));
                                  selectDateTypeSecond =
                                      "${"CHART.FILTER.QUARTER".tr()} ${selectedQuarter} ปี ${selectedYearQuarter} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";

                                  allTimeHeight = 100;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectDateType == "Quarter"
                                    ? selectButtonColor
                                    : null,
                              ),
                              foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectDateType == "Quarter"
                                    ? null
                                    : selectButtonColor.withOpacity(0.4),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Column(children: [
                                Center(
                                  child: Text(
                                    "CHART.FILTER.QUARTER".tr(),
                                    style: kfont22w_400black(),
                                  ),
                                ),
                                sectionBufferHeight(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        customButton: Container(
                                          width: 80,
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: backGroundApplication),
                                          child: Row(
                                            children: [
                                              Text(selectedYearQuarter),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: selectButtonColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        onMenuStateChange: null,
                                        value: selectedYearQuarter,
                                        items: listOfYear.map((String year) {
                                          return DropdownMenuItem<String>(
                                            value: year,
                                            child: Text(year),
                                          );
                                        }).toList(),
                                        onChanged: selectDateType == "Quarter"
                                            ? (String? newValue) {
                                                setState(() {
                                                  MapEntry<String, int>?
                                                      matchingEntry =
                                                      listOfQuarter.entries
                                                          .firstWhere(
                                                    (entry) =>
                                                        entry.key ==
                                                        selectedQuarter,
                                                  );
                                                  selectedYearQuarter =
                                                      newValue!;

                                                  if (selectedGraph[0]!) {
                                                    _vm.getSpiderChartFirstGraph(
                                                        int.parse(
                                                            selectedYearQuarter),
                                                        matchingEntry.value,
                                                        null,
                                                        _getIndexDayOfWeek(
                                                            selectDayOfWeek));
                                                    selectDateTypeFirst =
                                                        "${"CHART.FILTER.QUARTER".tr()} ${selectedQuarter} ปี ${selectedYearQuarter} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()} ";
                                                  } else {
                                                    _vm.getSpiderChartSecondGraph(
                                                        int.parse(
                                                            selectedYearQuarter),
                                                        matchingEntry.value,
                                                        null,
                                                        _getIndexDayOfWeek(
                                                            selectDayOfWeek));
                                                    selectDateTypeSecond =
                                                        "${"CHART.FILTER.QUARTER".tr()} ${selectedQuarter} ปี ${selectedYearQuarter} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                                  }
                                                });
                                              }
                                            : null,
                                      ),
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        customButton: Container(
                                          width: 60,
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: backGroundApplication),
                                          child: Row(
                                            children: [
                                              Text(selectedQuarter),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: selectButtonColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        onMenuStateChange: null,
                                        value: selectedQuarter,
                                        items: listOfQuarter.entries
                                            .map<DropdownMenuItem<String>>(
                                              (MapEntry<String, int> entry) =>
                                                  DropdownMenuItem<String>(
                                                value: entry.key,
                                                child: FittedBox(
                                                  child: Text(
                                                    ' ${entry.key}',
                                                    style: kfont22w_400black(),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: selectDateType == "Quarter"
                                            ? (String? newValue) {
                                                setState(() {
                                                  selectedQuarter = newValue!;
                                                  MapEntry<String, int>?
                                                      matchingEntry =
                                                      listOfQuarter.entries
                                                          .firstWhere(
                                                    (entry) =>
                                                        entry.key ==
                                                        selectedQuarter,
                                                  );

                                                  if (selectedGraph[0]!) {
                                                    _vm.getSpiderChartFirstGraph(
                                                        int.parse(
                                                            selectedYearQuarter),
                                                        matchingEntry.value,
                                                        null,
                                                        _getIndexDayOfWeek(
                                                            selectDayOfWeek));
                                                    selectDateTypeFirst =
                                                        "${"CHART.FILTER.QUARTER".tr()} ${selectedQuarter} ปี ${selectedYearQuarter} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                                  } else {
                                                    _vm.getSpiderChartSecondGraph(
                                                        int.parse(
                                                            selectedYearQuarter),
                                                        matchingEntry.value,
                                                        null,
                                                        _getIndexDayOfWeek(
                                                            selectDayOfWeek));
                                                    selectDateTypeSecond =
                                                        "${"CHART.FILTER.QUARTER".tr()} ${selectedQuarter} ปี ${selectedYearQuarter} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                                  }
                                                });
                                              }
                                            : null,
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sectionBufferHeight(bufferSection: 30),
                    Row(
                      children: [
                        Expanded(
                          flex: 120,
                          child: GestureDetector(
                            onTap: () {
                              selectDateType = "Year";
                              setState(() {
                                if (selectedGraph[0]!) {
                                  _vm.getSpiderChartFirstGraph(
                                      int.parse(selectedYear),
                                      null,
                                      null,
                                      _getIndexDayOfWeek(selectDayOfWeek));
                                  selectDateTypeFirst =
                                      "${"CHART.FILTER.YEAR".tr()} ${selectedYear} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";

                                  allTimeHeight = 100;
                                } else {
                                  _vm.getSpiderChartSecondGraph(
                                      int.parse(selectedYear),
                                      null,
                                      null,
                                      _getIndexDayOfWeek(selectDayOfWeek));
                                  allTimeHeight = 100;

                                  selectDateTypeSecond =
                                      "${"CHART.FILTER.YEAR".tr()} ${selectedYear} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              height: allTimeHeight == 0 ? 100 : allTimeHeight,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectDateType == "Year"
                                    ? selectButtonColor
                                    : null,
                              ),
                              foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectDateType == "Year"
                                    ? null
                                    : selectButtonColor.withOpacity(0.4),
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      "CHART.FILTER.YEAR".tr(),
                                      style: kfont22w_400black(),
                                    ),
                                  ),
                                  sectionBufferHeight(),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      customButton: Container(
                                        width: 80,
                                        height: 30,
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: backGroundApplication),
                                        child: Row(
                                          children: [
                                            Text(selectedYear),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_drop_down_rounded,
                                              color: selectButtonColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      value: selectedYear,
                                      items: listOfYear.map((String year) {
                                        return DropdownMenuItem<String>(
                                          value: year,
                                          child: Text(year),
                                        );
                                      }).toList(),
                                      onChanged: selectDateType == "Year"
                                          ? (String? newValue) {
                                              setState(() {
                                                if (selectedGraph[0]!) {
                                                  selectedYear = newValue!;
                                                  _vm.getSpiderChartFirstGraph(
                                                      int.parse(selectedYear),
                                                      null,
                                                      null,
                                                      _getIndexDayOfWeek(
                                                          selectDayOfWeek));

                                                  selectDateTypeFirst =
                                                      "${"CHART.FILTER.YEAR".tr()} ${selectedYear} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                                } else {
                                                  selectedYear = newValue!;
                                                  _vm.getSpiderChartSecondGraph(
                                                      int.parse(selectedYear),
                                                      null,
                                                      null,
                                                      _getIndexDayOfWeek(
                                                          selectDayOfWeek));

                                                  selectDateTypeSecond =
                                                      "${"CHART.FILTER.YEAR".tr()} ${selectedYear} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                                }
                                              });
                                            }
                                          : null,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        sectionBufferWidth(bufferSection: 15),
                        Expanded(
                          flex: 280,
                          child: GestureDetector(
                            onTap: () {
                              selectDateType = "Month";
                              setState(() {
                                MapEntry<String, dynamic>? matchingEntry =
                                    selectMonthList.entries.firstWhere(
                                  (entry) => entry.key == selectMonthString,
                                );

                                if (selectedGraph[0]!) {
                                  _vm.getSpiderChartFirstGraph(
                                      int.parse(selectedYearMonth),
                                      null,
                                      matchingEntry.value,
                                      _getIndexDayOfWeek(selectDayOfWeek));

                                  selectDateTypeFirst =
                                      "${"CHART.FILTER.MONTH".tr()} ${"CHART.MONTH.$selectMonthString".tr()} $selectedYearMonth วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                  allTimeHeight = 100;
                                } else {
                                  _vm.getSpiderChartSecondGraph(
                                      int.parse(selectedYearMonth),
                                      null,
                                      matchingEntry.value,
                                      _getIndexDayOfWeek(selectDayOfWeek));
                                  allTimeHeight = 100;
                                  selectDateTypeSecond =
                                      "${"CHART.FILTER.MONTH".tr()} ${"CHART.MONTH.$selectMonthString".tr()} $selectedYearMonth วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                  allTimeHeight = 100;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectDateType == "Month"
                                    ? selectButtonColor
                                    : null,
                              ),
                              foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectDateType == "Month"
                                    ? null
                                    : selectButtonColor.withOpacity(0.4),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Column(children: [
                                Center(
                                  child: Text(
                                    "CHART.FILTER.MONTH".tr(),
                                    style: kfont22w_400black(),
                                  ),
                                ),
                                sectionBufferHeight(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        customButton: Container(
                                          width: 125,
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: backGroundApplication),
                                          child: Row(
                                            children: [
                                              Text(
                                                  "CHART.MONTH.$selectMonthString"
                                                      .tr()),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: selectButtonColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        onMenuStateChange: null,
                                        value: selectMonthString,
                                        items: selectMonthList.entries
                                            .map<DropdownMenuItem<String>>(
                                              (MapEntry<String, dynamic>
                                                      entry) =>
                                                  DropdownMenuItem<String>(
                                                value: entry.key,
                                                child: FittedBox(
                                                  child: Text(
                                                    "CHART.MONTH.${entry.key}"
                                                        .tr(),
                                                    maxLines: 1,
                                                    style:
                                                        kfontH2InterBoldBlackColor(),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: selectDateType == "Month"
                                            ? (String? newValue) {
                                                setState(() {
                                                  selectMonthString = newValue!;
                                                  MapEntry<String, dynamic>?
                                                      matchingEntry =
                                                      selectMonthList.entries
                                                          .firstWhere(
                                                    (entry) =>
                                                        entry.key ==
                                                        selectMonthString,
                                                  );

                                                  if (selectedGraph[0]!) {
                                                    _vm.getSpiderChartFirstGraph(
                                                        int.parse(
                                                            selectedYearMonth),
                                                        null,
                                                        matchingEntry.value,
                                                        _getIndexDayOfWeek(
                                                            selectDayOfWeek));
                                                    selectDateTypeFirst =
                                                        "${"CHART.FILTER.MONTH".tr()} ${"CHART.MONTH.$selectMonthString".tr()} $selectedYearMonth วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                                  } else {
                                                    _vm.getSpiderChartSecondGraph(
                                                        int.parse(
                                                            selectedYearMonth),
                                                        null,
                                                        matchingEntry.value,
                                                        _getIndexDayOfWeek(
                                                            selectDayOfWeek));
                                                    selectDateTypeSecond =
                                                        "${"CHART.FILTER.MONTH".tr()} ${"CHART.MONTH.$selectMonthString".tr()} $selectedYearMonth วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                                  }
                                                });
                                              }
                                            : null,
                                      ),
                                    ),
                                    sectionBufferWidth(bufferSection: 10),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        customButton: Container(
                                          width: 72,
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: backGroundApplication),
                                          child: Row(
                                            children: [
                                              Text(selectedYearMonth),
                                              Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: selectButtonColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        value: selectedYearMonth,
                                        items: listOfYear.map((String year) {
                                          return DropdownMenuItem<String>(
                                            value: year,
                                            child: Text(year),
                                          );
                                        }).toList(),
                                        onChanged: selectDateType == "Month"
                                            ? (String? newValue) {
                                                setState(() {
                                                  selectedYearMonth = newValue!;
                                                  MapEntry<String, dynamic>?
                                                      matchingEntry =
                                                      selectMonthList.entries
                                                          .firstWhere(
                                                    (entry) =>
                                                        entry.key ==
                                                        selectMonthString,
                                                  );

                                                  if (selectedGraph[0]!) {
                                                    _vm.getSpiderChartFirstGraph(
                                                        int.parse(
                                                            selectedYearMonth),
                                                        null,
                                                        matchingEntry.value,
                                                        _getIndexDayOfWeek(
                                                            selectDayOfWeek));
                                                    selectDateTypeFirst =
                                                        "${"CHART.FILTER.MONTH".tr()} ${"CHART.MONTH.$selectMonthString".tr()} $selectedYearMonth วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                                  } else {
                                                    _vm.getSpiderChartSecondGraph(
                                                        int.parse(
                                                            selectedYearMonth),
                                                        null,
                                                        matchingEntry.value,
                                                        _getIndexDayOfWeek(
                                                            selectDayOfWeek));
                                                    selectDateTypeSecond =
                                                        "${"CHART.FILTER.MONTH".tr()} ${"CHART.MONTH.$selectMonthString".tr()} $selectedYearMonth วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
                                                  }
                                                });
                                              }
                                            : null,
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sectionBufferHeight(),
                    Text(
                      "2. ${"CHART.PICK_DAY_OF_WEEK".tr()}",
                      style: kfontH2InterBlackColor(),
                    ),
                    sectionBufferHeight(),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: selectButtonColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              ...listDateInWeek.entries.map((entry) {
                                return containerSelectDate(
                                  entry.key,
                                  selectDayOfWeek == entry.key,
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        sectionBufferHeight(bufferSection: 20),
                        if (!isAddGraph)
                          _buttonAddSubGraph()
                        else
                          Column(
                            children: [
                              sectionBufferHeight(bufferSection: 20),
                              toggleUserType(
                                height: height,
                                width: width,
                              ),
                              sectionBufferHeight(bufferSection: 35),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin:
                                        EdgeInsets.only(right: width * 0.01),
                                    decoration: ShapeDecoration(
                                        shape: StadiumBorder(),
                                        color: Colors.purple),
                                  ),
                                  Text(selectDateTypeFirst,
                                      style: kfontH2InterBoldBlackColor()),
                                ],
                              ),
                              sectionBufferHeight(bufferSection: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin:
                                        EdgeInsets.only(right: width * 0.01),
                                    decoration: ShapeDecoration(
                                        shape: StadiumBorder(),
                                        color: Colors.orange),
                                  ),
                                  Text(selectDateTypeSecond,
                                      style: kfontH2InterBoldBlackColor()),
                                  sectionBufferHeight(bufferSection: 20),
                                ],
                              ),
                            ],
                          ),
                        sectionBufferHeight(bufferSection: 20),
                        FutureBuilder(
                          future: Future.wait([
                            _vm.spiderChartDataFirstGraph,
                            _vm.spiderChartDataSecondGraph
                          ]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: double.infinity,
                                  height: 400,
                                  color: Colors.grey,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              print(snapshot.error);
                              return Text(
                                "ERROR_MESSAGE.ERROR_LOADING_FAIL".tr(),
                              );
                            } else if (snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              SpiderChartResponseModel spiderChartDataFirst =
                                  snapshot.data![0];
                              SpiderChartResponseModel spiderChartDataSecond =
                                  snapshot.data![1];
                              return Column(
                                children: [
                                  Center(
                                      child: _radarChart(
                                    spiderChartDataFirst: spiderChartDataFirst,
                                    spiderChartDataSecond:
                                        spiderChartDataSecond,
                                    graphIndex: 0,
                                  )),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                    sectionBufferHeight(bufferSection: 20),
                    _graphDescription()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Center _graphDescription() {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selectButtonColor.withOpacity(0.5)),
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: Text(
            "กราฟแสดงจำนวนลูกค้าเฉลี่ยใน วันจันทร์ ตลอดระยะเวลาที่ผ่านมาเฉลี่ยตลอด \n \n วันคิดเป็น 30 คน/ชั่วโมงในช่วงพีคมีลูกค้า 80 คน/ชั่วโมง",
            style: kfontH2InterBlackColor(),
            textAlign: TextAlign.center,
          )),
    );
  }

  GestureDetector _buttonAddSubGraph() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isAddGraph = true;
          selectedGraph[0] = true;
          selectedGraph[1] = false;
          selectDateType = "All Time";
          selectDateTypeFirst =
              "${"CHART.FILTER.ALL_TIME".tr()} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
          _vm.getSpiderChartFirstGraph(
              null, null, null, _getIndexDayOfWeek(selectDayOfWeek));
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: selectButtonColor, borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(children: [
          Container(
              child: Text(
            "Sub Graph",
            style: kfont26_400(),
          )),
          Spacer(),
          Text(
            "+",
            style: kfont26_400(),
          )
        ]),
      ),
    );
  }

  Widget _radarChart({
    required SpiderChartResponseModel spiderChartDataFirst,
    required SpiderChartResponseModel spiderChartDataSecond,
    required int graphIndex,
  }) {
    var features = ["รสชาติ", "บริการ", "ความคุ้มค่า", "ที่จอดรถ", "บรรยากาศ"];
    List<int> ticks = [1, 2, 3, 4, 5];
    features = features.sublist(0, numberOfFeatures.floor());
    late List<List<double>> data;

    if (spiderChartDataFirst.data!.isNotEmpty ||
        spiderChartDataSecond.data!.isNotEmpty) {
      if (isAddGraph &&
          spiderChartDataFirst.data!.isNotEmpty &&
          spiderChartDataSecond.data!.isNotEmpty) {
        data = [
          [
            spiderChartDataFirst.data![0].totalFlavour!,
            spiderChartDataFirst.data![0].totalService!,
            spiderChartDataFirst.data![0].totalWorthiness!,
            spiderChartDataFirst.data![0].totalparking!,
            spiderChartDataFirst.data![0].totalPlace!
          ],
          [
            spiderChartDataSecond.data![0].totalFlavour!,
            spiderChartDataSecond.data![0].totalService!,
            spiderChartDataSecond.data![0].totalWorthiness!,
            spiderChartDataSecond.data![0].totalparking!,
            spiderChartDataSecond.data![0].totalPlace!
          ]
        ];
      } else if (isAddGraph &&
          spiderChartDataFirst.data!.isNotEmpty &&
          spiderChartDataSecond.data!.isEmpty) {
        data = [
          [
            spiderChartDataFirst.data![0].totalFlavour!,
            spiderChartDataFirst.data![0].totalService!,
            spiderChartDataFirst.data![0].totalWorthiness!,
            spiderChartDataFirst.data![0].totalparking!,
            spiderChartDataFirst.data![0].totalPlace!
          ]
        ];
      } else if (isAddGraph &&
          spiderChartDataSecond.data!.isNotEmpty &&
          spiderChartDataFirst.data!.isEmpty) {
        data = [
          [
            spiderChartDataSecond.data![0].totalFlavour!,
            spiderChartDataSecond.data![0].totalService!,
            spiderChartDataSecond.data![0].totalWorthiness!,
            spiderChartDataSecond.data![0].totalparking!,
            spiderChartDataSecond.data![0].totalPlace!,
          ],
        ];
      } else if (spiderChartDataFirst.data!.isNotEmpty ||
          spiderChartDataSecond.data!.isEmpty) {
        data = [
          [
            spiderChartDataFirst.data![0].totalFlavour!,
            spiderChartDataFirst.data![0].totalService!,
            spiderChartDataFirst.data![0].totalWorthiness!,
            spiderChartDataFirst.data![0].totalparking!,
            spiderChartDataFirst.data![0].totalPlace!
          ]
        ];
      } else {
        data = [];
      }
    } else {
      data = [];
    }

    data = data
        .map((graph) => graph.sublist(0, numberOfFeatures.floor()))
        .toList();
    return Theme(
      data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent),
      child: AnimatedContainer(
        height: 400,
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: RadarChart(
            ticks: ticks,
            features: features,
            data: data,
            sides: 5,
            ticksTextStyle: kfontH3InterBlackColor(),
            featuresTextStyle: kfontH2InterBoldBlackColor(),
            graphColors: [Colors.purple, Colors.orange]),
      ),
    );
  }

  Expanded containerSelectDate(String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectDayOfWeek = title;
            MapEntry<String, dynamic>? matchingEntry =
                listDateInWeek.entries.firstWhere(
              (entry) => entry.key == selectDayOfWeek,
            );
            var selectedValue =
                matchingEntry.value == "" ? null : matchingEntry.value;
            if (selectedGraph[0]!) {
              if (selectDateType == "All Time") {
                _vm.getSpiderChartFirstGraph(null, null, null, selectedValue);
                selectDateTypeFirst =
                    "${"CHART.FILTER.ALL_TIME".tr()} วัน ${"CHART.DAY_OF_WEEK.${matchingEntry.key}".tr()}";
              } else if (selectDateType == "Quarter") {
                MapEntry<String, int>? matchingQuarter =
                    listOfQuarter.entries.firstWhere(
                  (entry) => entry.key == selectedQuarter,
                );
                _vm.getSpiderChartFirstGraph(int.parse(selectedYearQuarter),
                    matchingQuarter.value, null, selectedValue);
                selectDateTypeFirst =
                    "${"CHART.FILTER.QUARTER".tr()} ${selectedQuarter} ปี ${selectedYearQuarter} วัน ${"CHART.DAY_OF_WEEK.${matchingEntry.key}".tr()}";
              } else if (selectDateType == "Month") {
                MapEntry<String, dynamic>? matchingMonth =
                    selectMonthList.entries.firstWhere(
                  (entry) => entry.key == selectMonthString,
                );
                _vm.getSpiderChartFirstGraph(
                  int.parse(selectedYearMonth),
                  null,
                  matchingMonth.value,
                );
                selectDateTypeFirst =
                    "${"CHART.FILTER.MONTH".tr()} ${"CHART.MONTH.$selectMonthString".tr()} $selectedYearMonth วัน ${"CHART.DAY_OF_WEEK.${matchingEntry.key}".tr()}";
              } else if (selectDateType == "Year") {
                _vm.getSpiderChartFirstGraph(
                    int.parse(selectedYear), null, null, selectedValue);
                selectDateTypeFirst =
                    "${"CHART.FILTER.YEAR".tr()} ${selectedYear} วัน ${"CHART.DAY_OF_WEEK.${matchingEntry.key}".tr()}";
              }
            } else {
              if (selectDateType == "All Time") {
                _vm.getSpiderChartSecondGraph(null, null, null, selectedValue);
                selectDateTypeSecond =
                    "${"CHART.FILTER.ALL_TIME".tr()} วัน ${"CHART.DAY_OF_WEEK.${matchingEntry.key}".tr()}";
              } else if (selectDateType == "Quarter") {
                MapEntry<String, int>? matchingQuarter =
                    listOfQuarter.entries.firstWhere(
                  (entry) => entry.key == selectedQuarter,
                );
                _vm.getSpiderChartSecondGraph(int.parse(selectedYearQuarter),
                    matchingQuarter.value, null, selectedValue);
                selectDateTypeSecond =
                    "${"CHART.FILTER.QUARTER".tr()} ${selectedQuarter} ปี ${selectedYearQuarter} วัน ${"CHART.DAY_OF_WEEK.${matchingEntry.key}".tr()}";
              } else if (selectDateType == "Month") {
                MapEntry<String, dynamic>? matchingMonth =
                    selectMonthList.entries.firstWhere(
                  (entry) => entry.key == selectMonthString,
                );
                _vm.getSpiderChartSecondGraph(
                  int.parse(selectedYearMonth),
                  null,
                  matchingMonth.value,
                );
                selectDateTypeSecond =
                    "${"CHART.FILTER.MONTH".tr()} ${"CHART.MONTH.$selectMonthString".tr()} $selectedYearMonth วัน ${"CHART.DAY_OF_WEEK.${matchingEntry.key}".tr()}";
              } else if (selectDateType == "Year") {
                _vm.getSpiderChartSecondGraph(
                    int.parse(selectedYear), null, null, selectedValue);
                selectDateTypeSecond =
                    "${"CHART.FILTER.YEAR".tr()} ${selectedYear} วัน ${"CHART.DAY_OF_WEEK.${matchingEntry.key}".tr()}";
              }
            }
          });
        },
        child: Column(
          children: [
            Container(
              width: 100,
              height: 40,
              // padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: isSelected
                    ? Border(
                        bottom: BorderSide(
                          color:
                              Colors.black, // Change the border color as needed
                          width: 5.0, // Adjust the border width as needed
                        ),
                      )
                    : null,
                color: isSelected
                    ? backGroundButton.withOpacity(.5)
                    : backGroundButton,
              ),
              child: Center(
                child: Text(
                  title,
                  style: kfontH4InterBlackColor(),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int? _getIndexDayOfWeek(String title) {
    // Check if the key exists in the map
    if (listDateInWeek.containsKey(title)) {
      // Access the value using the title key
      return listDateInWeek[title];
    } else {
      // Handle the case where the key is not found in the map
      return null;
    }
  }

  Widget toggleUserType({required height, required width}) {
    return AnimatedToggleSwitch.size(
      current: _selectGraph,
      values: _graphOrdersList,
      iconOpacity: 1,
      height: height * 0.045,
      indicatorSize: Size.fromWidth(width * 0.22),
      iconAnimationType: AnimationType.onHover,
      styleAnimationType: AnimationType.onHover,
      iconBuilder: (value) => Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: value == _graphOrdersList[0]
                ? [
                    WidgetSpan(
                      child: Icon(
                        Icons.insert_chart_outlined_rounded,
                        color: _selectGraph == _graphOrdersList[0]
                            ? Colors.white
                            : Colors.black,
                        shadows: const [
                          Shadow(
                            blurRadius: 0.5,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ]
                : [
                    WidgetSpan(
                      child: Icon(
                        Icons.pie_chart_outline_sharp,
                        // color: Colors.white,
                        color: _selectGraph == _graphOrdersList[1]
                            ? Colors.white
                            : Colors.black,
                        shadows: const [
                          Shadow(
                            blurRadius: 0.5,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
          ),
        ),
      ),
      style: const ToggleStyle(
        borderColor: Colors.transparent,
      ),
      borderWidth: 5.0,
      styleBuilder: (i) {
        final color = colorBuilder(i);
        return ToggleStyle(
          backgroundColor: color.withOpacity(0.3),
          indicatorColor: color,
        );
      },
      onChanged: (i) {
        setState(() {
          _selectGraph = i;
          if (_selectGraph == _graphOrdersList[0]) {
            selectedGraph[0] = true;
            selectedGraph[1] = false;
            selectDateType = "All Time";
            selectDateTypeFirst =
                "${"CHART.FILTER.ALL_TIME".tr()} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
            _vm.getSpiderChartFirstGraph(
                null, null, null, _getIndexDayOfWeek(selectDayOfWeek));
          } else if (_selectGraph == _graphOrdersList[1]) {
            selectedGraph[0] = false;
            selectedGraph[1] = true;
            selectDateType = "All Time";
            selectDateTypeSecond =
                "${"CHART.FILTER.ALL_TIME".tr()} วัน ${"CHART.DAY_OF_WEEK.${selectDayOfWeek}".tr()}";
            _vm.getSpiderChartSecondGraph(
                null, null, null, _getIndexDayOfWeek(selectDayOfWeek));
          }
        });
      },
    );
  }

  Color colorBuilder(String value) {
    switch (value) {
      case "Graph 1":
        return Colors.purple;
      // break;
      case "Graph 2":
        return Colors.orange;
      // break;
      default:
        return Colors.red;
    }
  }
}
