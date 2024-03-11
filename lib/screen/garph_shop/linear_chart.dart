import 'package:coffee_application/model/response/rank_bar_chart_response.dart';
import 'package:coffee_application/viewmodel/review_rank_bar_chart_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:coffee_application/data/widget/sliver_multipleline_appbar.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinearChartPage extends StatefulWidget {
  const LinearChartPage({super.key});

  @override
  State<LinearChartPage> createState() => _LinearChartPageState();
}

class _LinearChartPageState extends State<LinearChartPage> {
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

  String selectDataFilterType = "ALL";
  List<String> listDataFilterType = [
    "ALL",
    "FLAVOUR",
    "PLACE",
    "SERVICE",
    "PARKING",
    "WORTHINESS",
  ];

  double allTimeHeight = 0;

  late final ReviewRankBarChartVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = ReviewRankBarChartVM();
    _vm.getRankChartData();
  }

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
                title: "CHART.BAR_CHART_PAGE.LINEAR_CHART_TITLE".tr(),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
                                  _vm.getRankChartData();
                                  setState(() {});
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height:
                                    allTimeHeight == 0 ? 100 : allTimeHeight,
                                padding: const EdgeInsets.all(15),
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

                                  _vm.getRankChartData(
                                      int.parse(selectedYearQuarter),
                                      matchingEntry.value);
                                  allTimeHeight = 100;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
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
                                padding: const EdgeInsets.all(15),
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
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: backGroundApplication),
                                            child: Row(
                                              children: [
                                                Text(selectedYearQuarter),
                                                const Spacer(),
                                                const Icon(
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
                                                    _vm.getRankChartData(
                                                        int.parse(
                                                            selectedYearQuarter),
                                                        matchingEntry.value);
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
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: backGroundApplication),
                                            child: Row(
                                              children: [
                                                Text(selectedQuarter),
                                                const Spacer(),
                                                const Icon(
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
                                                      style:
                                                          kfont22w_400black(),
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
                                                    _vm.getRankChartData(
                                                        int.parse(
                                                            selectedYearQuarter),
                                                        matchingEntry.value);
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
                                  _vm.getRankChartData(int.parse(selectedYear));
                                  allTimeHeight = 100;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height:
                                    allTimeHeight == 0 ? 100 : allTimeHeight,
                                padding: const EdgeInsets.all(15),
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
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: backGroundApplication),
                                          child: Row(
                                            children: [
                                              Text(selectedYear),
                                              const Spacer(),
                                              const Icon(
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
                                                  selectedYear = newValue!;
                                                  _vm.getRankChartData(
                                                      int.parse(selectedYear));
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

                                  _vm.getRankChartData(
                                      int.parse(selectedYearMonth),
                                      null,
                                      matchingEntry.value);
                                  allTimeHeight = 100;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
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
                                padding: const EdgeInsets.all(15),
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
                                            width: 80,
                                            height: 30,
                                            padding: const EdgeInsets.only(
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
                                                const Spacer(),
                                                const Icon(
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
                                                      "${"CHART.MONTH.${entry.key}".tr()}",
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
                                                    selectMonthString =
                                                        newValue!;
                                                    MapEntry<String, dynamic>?
                                                        matchingEntry =
                                                        selectMonthList.entries
                                                            .firstWhere(
                                                      (entry) =>
                                                          entry.key ==
                                                          selectMonthString,
                                                    );

                                                    _vm.getRankChartData(
                                                        int.parse(
                                                            selectedYearMonth),
                                                        null,
                                                        matchingEntry.value);
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
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: backGroundApplication),
                                            child: Row(
                                              children: [
                                                Text(selectedYearMonth),
                                                const Icon(
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
                                                    selectedYearMonth =
                                                        newValue!;
                                                    MapEntry<String, dynamic>?
                                                        matchingEntry =
                                                        selectMonthList.entries
                                                            .firstWhere(
                                                      (entry) =>
                                                          entry.key ==
                                                          selectMonthString,
                                                    );

                                                    _vm.getRankChartData(
                                                        int.parse(
                                                            selectedYearMonth),
                                                        null,
                                                        matchingEntry.value);
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
                        "2. ${"CHART.CATEGORY".tr()}",
                        style: kfontH2InterBlackColor(),
                      ),
                      sectionBufferHeight(),
                      FutureBuilder(
                        future: _vm.rankChartData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(),
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
                            ReviewRankBarChartResponse rankChartData =
                                snapshot.data!;
                            return Column(
                              children: [
                                _selectTypeSection(),
                                sectionBufferHeight(bufferSection: 20),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    _legendHandMade(width, "MIN", Colors.blue),
                                    _legendHandMade(width, "MAX", Colors.red),
                                    _legendHandMade(
                                        width, "SHOP AVG", Colors.green),
                                    _legendHandMade(
                                        width, "MY AVG", Colors.purple),
                                  ],
                                ),
                                sectionBufferHeight(bufferSection: 20),
                                _barChart(
                                    _getChartDataBySelectName(rankChartData),
                                    _getChartDataDashBySelectName(
                                        rankChartData)),
                                Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: selectButtonColor
                                              .withOpacity(0.5)),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(30),
                                      child: Text(
                                        "กราฟแสดงรีวิวจากลูกค้าที่เข้ามาใช้บริการของร้าน \n \n จากกราฟสีต่างๆแสดงให้เห็นถึงรายละเอียดของคะแนนต่างๆของร้าน",
                                        style: kfontH2InterBlackColor(),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legendHandMade(double width, String title, Color color) {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
        child: Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.only(right: width * 0.01, left: width * 0.01),
          decoration:
              ShapeDecoration(shape: const StadiumBorder(), color: color),
        ),
      ),
      WidgetSpan(
        child: Text(
          "CHART.LABEL.$title".tr(),
          style: kfontH2InterBoldBlackColor(),
        ),
      ),
    ]));
  }

  List<ChartData> _getChartDataBySelectName(
      ReviewRankBarChartResponse chartData) {
    switch (selectDataFilterType) {
      case "ALL":
        return _createChartDataOwnShop(
          chartData.data?.totalScore?.avg,
          chartData.data?.totalScore?.shopAvg,
        );
      case "FLAVOUR":
        return _createChartDataOwnShop(
          chartData.data?.flavour?.avg,
          chartData.data?.flavour?.shopAvg,
        );
      case "PLACE":
        return _createChartDataOwnShop(
          chartData.data?.place?.avg,
          chartData.data?.place?.shopAvg,
        );
      case "SERVICE":
        return _createChartDataOwnShop(
          chartData.data?.service?.avg,
          chartData.data?.service?.shopAvg,
        );
      case "PARKING":
        return _createChartDataOwnShop(
          chartData.data?.parking?.avg,
          chartData.data?.parking?.shopAvg,
        );
      case "WORTHINESS":
        return _createChartDataOwnShop(
          chartData.data?.worthiness?.avg,
          chartData.data?.worthiness?.shopAvg,
        );
      default:
        return [];
    }
  }

  List<ChartData> _getChartDataDashBySelectName(
      ReviewRankBarChartResponse chartData) {
    switch (selectDataFilterType) {
      case "ALL":
        return _createChartDataDashLine(
          chartData.data?.totalScore?.min,
          chartData.data?.totalScore?.max,
        );
      case "FLAVOUR":
        return _createChartDataDashLine(
          chartData.data?.flavour?.min,
          chartData.data?.flavour?.max,
        );
      case "PLACE":
        return _createChartDataDashLine(
          chartData.data?.place?.min,
          chartData.data?.place?.max,
        );
      case "SERVICE":
        return _createChartDataDashLine(
          chartData.data?.service?.min,
          chartData.data?.service?.max,
        );
      case "PARKING":
        return _createChartDataDashLine(
          chartData.data?.parking?.min,
          chartData.data?.parking?.max,
        );
      case "WORTHINESS":
        return _createChartDataDashLine(
          chartData.data?.worthiness?.min,
          chartData.data?.worthiness?.max,
        );
      default:
        return [];
    }
  }

  List<ChartData> _createChartDataOwnShop(double? shopAvg, double? avg) {
    if (avg == null|| shopAvg == null) {
      return [];
    }

    return [
      ChartData("ร้านของฉัน", avg, Colors.purple),
      ChartData("เฉลี่ยทุกร้าน", shopAvg, Colors.green.shade300),
    ];
  }

  List<ChartData> _createChartDataDashLine(
      double? min, double? max) {
    if (min == null || max == null ) {
      return [];
    }

    return [
      ChartData("MIN", min, Colors.blue),
      ChartData("MAX", max, Colors.red),
    ];
  }

  Center _graphDescription() {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selectButtonColor.withOpacity(0.5)),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Text(
            "กราฟแสดงอันดับคะแนนของร้านในหมวด บรรยากาศ ในเดือนกุมภาภันธ์ 2022",
            style: kfontH2InterBlackColor(),
            textAlign: TextAlign.center,
          )),
    );
  }

  Container _selectTypeSection() {
    return Container(
      decoration: BoxDecoration(
        color: selectButtonColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          containerSelectDate(listDataFilterType[0],
              selectDataFilterType == listDataFilterType[0]),
          containerSelectDate(listDataFilterType[1],
              selectDataFilterType == listDataFilterType[1]),
          containerSelectDate(listDataFilterType[2],
              selectDataFilterType == listDataFilterType[2]),
          containerSelectDate(listDataFilterType[3],
              selectDataFilterType == listDataFilterType[3]),
          containerSelectDate(listDataFilterType[4],
              selectDataFilterType == listDataFilterType[4]),
          containerSelectDate(listDataFilterType[5],
              selectDataFilterType == listDataFilterType[5]),
        ],
      ),
    );
  }

  Center _barChart(
    List<ChartData> chartData,
    List<ChartData> dashData,
  ) {
    return Center(
      child: Container(
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              labelStyle: kfontH2InterBlackColor(),
            ),
            primaryYAxis: NumericAxis(
              plotBands: [
                PlotBand(
                    color: Colors.grey.withOpacity(0.0),
                    start: dashData[0].y,
                    end: 20,
                    
                    text: dashData[0].y.toStringAsFixed(2),
                    verticalTextAlignment: TextAnchor.end,
                    horizontalTextAlignment: TextAnchor.end,
                    textStyle: kfontH2InterBoldBlackColor()
                        .copyWith(color: Colors.blue),

                    //Specify the width for the line
                    borderWidth: 3,
                    //Specify the color for the line
                    borderColor: Colors.blue,
                    //Specify the dash array for the line
                    dashArray: const <double>[4, 5]),
                PlotBand(
                    color: Colors.grey.withOpacity(0.0),
                    start: dashData[1].y,
                    end: 20,
                    
                    text: dashData[1].y.toStringAsFixed(2),
                    verticalTextAlignment: TextAnchor.end,
                    horizontalTextAlignment: TextAnchor.end,
                    textStyle: kfontH2InterBoldBlackColor()
                        .copyWith(color: Colors.red),

                    //Specify the width for the line
                    borderWidth: 3,
                    //Specify the color for the line
                    borderColor: Colors.red,
                    //Specify the dash array for the line
                    dashArray: const <double>[4, 5])
              ],
              maximum: 5,
              minimum: 0,
              labelStyle: kfontH2InterBlackColor(),
              numberFormat: NumberFormat.decimalPatternDigits(
                decimalDigits: 1,
              ),
            ),
            series: <CartesianSeries<ChartData, dynamic>>[
              ColumnSeries<ChartData, dynamic>(
                dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.top,
                    textStyle: kfontH2InterWhiteColor(),
                    borderRadius: BorderSide.strokeAlignCenter),
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                width: 0.35,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                pointColorMapper: (ChartData data, _) => data.color,
              ),
            ]),
      ),
    );
  }

  Expanded containerSelectDate(String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectDataFilterType = title;
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
                    ? const Border(
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
                  "CHART.DATA_CATEGORY.$title".tr(),
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
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color? color;
}
