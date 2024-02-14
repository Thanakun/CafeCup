import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:coffee_application/data/widget/sliver_multipleline_appbar.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartPage extends StatefulWidget {
  const PieChartPage({super.key});

  @override
  State<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  String selectedYearQuarter = "2022"; // Set a default year
  String selectedQuarter = "Q1"; // Set a default quarter

  String selectedYear = "2022"; // Set a default year

  String selectedYearMonth = "2022"; // Set a default year
  String selectMonthString = "December";

  List<String> selectMonthList = [
    "January",
    "Febuary",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
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
  List<String> listOfQuarter = ["Q1", "Q2", "Q3", "Q4"];

  String selectDayOfWeek = "ALL";
  List<String> listDateInWeek = [
    "ALL",
    "SUN",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT"
  ];

  double allTimeHeight = 0;

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
                                    "All Time",
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
                                      "Quarter",
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
                                                    selectedYearQuarter =
                                                        newValue!;
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
                                          items: listOfQuarter
                                              .map((String quarter) {
                                            return DropdownMenuItem<String>(
                                              value: quarter,
                                              child: Text(quarter),
                                            );
                                          }).toList(),
                                          onChanged: selectDateType == "Quarter"
                                              ? (String? newValue) {
                                                  setState(() {
                                                    selectedQuarter = newValue!;
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
                                        "Year",
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
                                              Text(selectedYearQuarter),
                                              const Spacer(),
                                              const Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: selectButtonColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        value: selectedYearQuarter,
                                        items: listOfYear.map((String year) {
                                          return DropdownMenuItem<String>(
                                            value: year,
                                            child: Text(year),
                                          );
                                        }).toList(),
                                        onChanged: selectDateType == "Year"
                                            ? (String? newValue) {
                                                setState(() {
                                                  selectedYearQuarter =
                                                      newValue!;
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
                                // Handle the tap for the "Quarter" section
                                selectDateType = "Month";
                                setState(() {
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
                                      "Month",
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
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: backGroundApplication),
                                            child: Row(
                                              children: [
                                                Text(selectMonthString),
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
                                          items: selectMonthList
                                              .map((String month) {
                                            return DropdownMenuItem<String>(
                                              value: month,
                                              child: Text(month),
                                            );
                                          }).toList(),
                                          onChanged: selectDateType == "Month"
                                              ? (String? newValue) {
                                                  setState(() {
                                                    selectMonthString =
                                                        newValue!;
                                                  });
                                                }
                                              : null,
                                        ),
                                      ),
                                      sectionBufferWidth(bufferSection: 10),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          customButton: Container(
                                            width: 100,
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
                      Container(
                        decoration: BoxDecoration(
                          color: selectButtonColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            containerSelectDate(listDateInWeek[0],
                                selectDayOfWeek == listDateInWeek[0]),
                            containerSelectDate(listDateInWeek[1],
                                selectDayOfWeek == listDateInWeek[1]),
                            containerSelectDate(listDateInWeek[2],
                                selectDayOfWeek == listDateInWeek[2]),
                            containerSelectDate(listDateInWeek[3],
                                selectDayOfWeek == listDateInWeek[3]),
                            containerSelectDate(listDateInWeek[4],
                                selectDayOfWeek == listDateInWeek[4]),
                            containerSelectDate(listDateInWeek[5],
                                selectDayOfWeek == listDateInWeek[5]),
                            containerSelectDate(listDateInWeek[6],
                                selectDayOfWeek == listDateInWeek[6]),
                            containerSelectDate(listDateInWeek[7],
                                selectDayOfWeek == listDateInWeek[7]),
                          ],
                        ),
                      ),
                      sectionBufferHeight(bufferSection: 20),
                      Center(
                          child: Container(
                              child: SfCircularChart(series: <CircularSeries>[
                        // Render pie chart
                        PieSeries<ChartData, String>(
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            strokeWidth: 1,
                            strokeColor: Colors.black,
                            dataSource: chartData,
                            pointColorMapper: (ChartData data, _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y)
                      ]))),
                      Center(
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
          setState(() {
            selectDayOfWeek = title;
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

  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
