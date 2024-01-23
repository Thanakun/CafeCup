import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/data/widget/sliver_multipleline_appbar.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartPage extends StatefulWidget {
  const BarChartPage({super.key});

  @override
  State<BarChartPage> createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
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
                title: "กราฟแสดงจำนวนลูกค้า เทียบตามช่วงเวลา",
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
                        "1. เลือกช่วงเวลา",
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
                                      "Month",
                                      style: kfont22w_400black(),
                                    ),
                                  ),
                                  sectionBufferHeight(),
                                  Row(
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
                                                Text(selectMonthString),
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
                                            width: 70.9,
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
                        "2. เลือกวัน",
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
                          child: SfCartesianChart(
                            series: <CartesianSeries>[
                              HistogramSeries<ChartData1, double>(
                                  dataSource: histogramData,
                                  showNormalDistributionCurve: true,
                                  curveColor:
                                      const Color.fromRGBO(192, 108, 132, 1),
                                  binInterval: 20,
                                  yValueMapper: (ChartData1 data, _) => data.y)
                            ],
                          ),
                        ),
                      ),
                      Center(
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
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<ChartData1> histogramData = <ChartData1>[
    ChartData1(5.250),
    ChartData1(7.750),
    ChartData1(0.0),
    ChartData1(8.275),
    ChartData1(9.750),
    ChartData1(7.750),
    ChartData1(8.275),
    ChartData1(6.250),
    ChartData1(5.750),
    ChartData1(5.250),
    ChartData1(23.000),
    ChartData1(26.500),
    ChartData1(26.500),
    ChartData1(27.750),
    ChartData1(25.025),
    ChartData1(26.500),
    ChartData1(28.025),
    ChartData1(29.250),
    ChartData1(26.750),
    ChartData1(27.250),
    ChartData1(26.250),
    ChartData1(25.250),
    ChartData1(34.500),
    ChartData1(25.625),
    ChartData1(25.500),
    ChartData1(26.625),
    ChartData1(36.275),
    ChartData1(36.250),
    ChartData1(26.875),
    ChartData1(40.000),
    ChartData1(43.000),
    ChartData1(46.500),
    ChartData1(47.750),
    ChartData1(45.025),
    ChartData1(56.500),
    ChartData1(56.500),
    ChartData1(58.025),
    ChartData1(59.250),
    ChartData1(56.750),
    ChartData1(57.250),
    ChartData1(46.250),
    ChartData1(55.250),
    ChartData1(44.500),
    ChartData1(45.525),
    ChartData1(55.500),
    ChartData1(46.625),
    ChartData1(46.275),
    ChartData1(56.250),
    ChartData1(46.875),
    ChartData1(43.000),
    ChartData1(46.250),
    ChartData1(55.250),
    ChartData1(44.500),
    ChartData1(45.425),
    ChartData1(55.500),
    ChartData1(56.625),
    ChartData1(46.275),
    ChartData1(56.250),
    ChartData1(46.875),
    ChartData1(43.000),
    ChartData1(46.250),
    ChartData1(55.250),
    ChartData1(44.500),
    ChartData1(45.425),
    ChartData1(55.500),
    ChartData1(46.625),
    ChartData1(56.275),
    ChartData1(46.250),
    ChartData1(56.875),
    ChartData1(41.000),
    ChartData1(63.000),
    ChartData1(66.500),
    ChartData1(67.750),
    ChartData1(65.025),
    ChartData1(66.500),
    ChartData1(76.500),
    ChartData1(78.025),
    ChartData1(79.250),
    ChartData1(76.750),
    ChartData1(77.250),
    ChartData1(66.250),
    ChartData1(75.250),
    ChartData1(74.500),
    ChartData1(65.625),
    ChartData1(75.500),
    ChartData1(76.625),
    ChartData1(76.275),
    ChartData1(66.250),
    ChartData1(66.875),
    ChartData1(80.000),
    ChartData1(85.250),
    ChartData1(87.750),
    ChartData1(89.000),
    ChartData1(88.275),
    ChartData1(89.750),
    ChartData1(97.750),
    ChartData1(98.275),
    ChartData1(96.250),
    ChartData1(95.750),
    ChartData1(95.250)
  ];
}

class ChartData1 {
  ChartData1(this.y);
  final double y;
}
