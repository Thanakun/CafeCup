import 'package:coffee_application/model/response/pie_graph_response.dart';
import 'package:coffee_application/viewmodel/pie_chart_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:coffee_application/data/widget/sliver_multipleline_appbar.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartPage extends StatefulWidget {
  const PieChartPage({super.key});

  @override
  State<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
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

  double allTimeHeight = 0;

  late final PieChartVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = PieChartVM();
    _vm.getPieChartData();
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
                title: "CHART.PIE_CHART_PAGE.PIE_CHART_TITLE".tr(),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                                  _vm.getPieChartData();
                                  setState(() {});
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                height:
                                    allTimeHeight == 0 ? 100 : allTimeHeight,
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

                                  _vm.getPieChartData(
                                      int.parse(selectedYearQuarter),
                                      matchingEntry.value);
                                  allTimeHeight = 100;
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
                                                    _vm.getPieChartData(
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
                                                    _vm.getPieChartData(
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
                                  _vm.getPieChartData(int.parse(selectedYear));
                                  allTimeHeight = 100;
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                height:
                                    allTimeHeight == 0 ? 100 : allTimeHeight,
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
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
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
                                                  selectedYear = newValue!;
                                                  _vm.getPieChartData(
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

                                  _vm.getPieChartData(
                                      int.parse(selectedYearMonth),
                                      null,
                                      matchingEntry.value);
                                  allTimeHeight = 100;
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

                                                    _vm.getPieChartData(
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

                                                    _vm.getPieChartData(
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
                        "2. ${"CHART.PICK_DAY_OF_WEEK".tr()}",
                        style: kfontH2InterBlackColor(),
                      ),
                      sectionBufferHeight(),
                      FutureBuilder(
                        future: _vm.pieChartData,
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
                            PieChartGraphResponse pieChartData = snapshot.data!;
                            return Column(
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
                                Center(
                                    child: SfCircularChart(
                                        onDataLabelRender: (dataLabelArgs) {
                                          dataLabelArgs.textStyle =
                                              kfont26Bold_400();
                                        },
                                        legend: Legend(
                                            isVisible: true,
                                            textStyle:
                                                kfontH1InterBoldBlackColor()),
                                        series: <CircularSeries>[
                                      // Render pie chart
                                      PieSeries<PieChartData, String>(
                                          explode: true,
                                          explodeAll: true,
                                          explodeOffset: '10%',
                                          strokeWidth: 1.5,
                                          strokeColor:
                                              Colors.black.withOpacity(0.5),
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true,
                                              labelPosition:
                                                  ChartDataLabelPosition
                                                      .outside),
                                          // legendIconType: LegendIconType.circle,
                                          dataSource: pieDataTOgraphData(
                                              pieChartData.data ?? []),
                                          pointColorMapper:
                                              (PieChartData data, _) =>
                                                  data.color,
                                          xValueMapper:
                                              (PieChartData data, _) => data.x,
                                          yValueMapper:
                                              (PieChartData data, _) => data.y)
                                    ])),
                                Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: selectButtonColor
                                              .withOpacity(0.5)),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(30),
                                      child: Text(
                                        "กราฟแสดงจำนวนลูกค้าเฉลี่ยใน วันจันทร์ ตลอดระยะเวลาที่ผ่านมาเฉลี่ยตลอด \n \n วันคิดเป็น 30 คน/ชั่วโมงในช่วงพีคมีลูกค้า 80 คน/ชั่วโมง",
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

  Expanded containerSelectDate(String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(
            () {
              selectDayOfWeek = title;
              MapEntry<String, dynamic>? matchingEntry =
                  listDateInWeek.entries.firstWhere(
                (entry) => entry.key == selectDayOfWeek,
              );
              var selectedValue =
                  matchingEntry.value == "" ? null : matchingEntry.value;

              if (selectDateType == "All Time") {
                _vm.getPieChartData(null, null, null, selectedValue);
              } else if (selectDateType == "Quarter") {
                MapEntry<String, int>? matchingQuarter =
                    listOfQuarter.entries.firstWhere(
                  (entry) => entry.key == selectedQuarter,
                );
                _vm.getPieChartData(int.parse(selectedYearQuarter),
                    matchingQuarter.value, null, selectedValue);
              } else if (selectDateType == "Month") {
                MapEntry<String, dynamic>? matchingMonth =
                    selectMonthList.entries.firstWhere(
                  (entry) => entry.key == selectMonthString,
                );
                _vm.getPieChartData(
                  int.parse(selectedYearMonth),
                  null,
                  matchingMonth.value,
                );
              } else if (selectDateType == "Year") {
                _vm.getPieChartData(
                    int.parse(selectedYear), null, null, selectedValue);
              }
            },
          );
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

  List<PieChartData> pieDataTOgraphData(
    List<Data> pieChartData,
  ) {
    List<PieChartData> graphData = [];
    for (int i = 0; i < pieChartData.length; i++) {
      if (pieChartData[i].sId == null) {
        graphData.add(PieChartData("GRAPH.NOT_SPECIFIC".tr(),
            pieChartData[i].count ?? 0, Colors.grey));
      } else if (pieChartData[i].sId == "UNDER_22") {
        graphData.add(PieChartData("GRAPH.UNDER_22".tr(),
            pieChartData[i].count ?? 0, Color.fromARGB(255, 64, 26, 170)));
      } else if (pieChartData[i].sId == "23_TO_40") {
        graphData.add(PieChartData("GRAPH.23_TO_40".tr(),
            pieChartData[i].count ?? 0, Color.fromARGB(255, 0, 255, 0)));
      } else if (pieChartData[i].sId == "41_TO_60") {
        graphData.add(PieChartData("GRAPH.41_TO_60".tr(),
            pieChartData[i].count ?? 0, Color.fromARGB(255, 255, 208, 0)));
      } else if (pieChartData[i].sId == "AFTER_61") {
        PieChartData("GRAPH.AFTER_61".tr(), pieChartData[i].count ?? 0,
            Color.fromARGB(255, 255, 0, 0));
      }
    }
    return graphData;
  }
}

class PieChartData {
  PieChartData(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color? color;
}
