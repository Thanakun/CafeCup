import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/garph_shop/bar_chart.dart';
import 'package:flutter_application_1/screen/garph_shop/linear_chart.dart';
import 'package:flutter_application_1/screen/garph_shop/pie_chart.dart';
import 'package:flutter_application_1/screen/garph_shop/web_chart.dart';
import 'package:flutter_application_1/screen/my_component/buttom_navigationbar_shop.dart';
import 'package:flutter_application_1/utility/my_constant.dart';

class ShopGraphPage extends StatefulWidget {
  const ShopGraphPage({super.key});

  @override
  State<ShopGraphPage> createState() => _ShopGraphPageState();
}

class _ShopGraphPageState extends State<ShopGraphPage> {
  final Map<String, String> graphDataMap = {
    'barChart': 'กราฟแสดงจำนวนลูกค้า',
    'pieChart': 'กราฟแสดงช่วงอายุ',
    'webChart': 'กราฟแสดงคะแนนของร้าน',
    'linearChart': 'กราฟแสดงอันดับคะแนน',
  };
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ShopBottomNavigationBar(
          pageName: "ANALYSIS",
        ),
        backgroundColor: const Color.fromRGBO(255, 245, 233, 1),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              width: width,
              height: height,
              margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
              child: SingleChildScrollView(
                child: Column(children: [
                  graphContainer(
                    label: "กราฟแสดงจำนวนลูกค้า",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BarChartPage()));
                    },
                    imageGraphPath: getImagePathForGraphType("barChart"),
                  ),
                  graphContainer(
                    label: "กราฟแสดงช่วงอายุ",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PieChartPage()));
                    },
                    imageGraphPath: getImagePathForGraphType("pieChart"),
                  ),
                  graphContainer(
                    label: "กราฟแสดงคะแนนของร้าน",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WebChartPage()));
                    },
                    imageGraphPath: getImagePathForGraphType("webChart"),
                  ),
                  graphContainer(
                    label: "กราฟแสดงอันดับคะแนน",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LinearChartPage()));
                    },
                    imageGraphPath: getImagePathForGraphType("linearChart"),
                  )
                ]),
              )),
        ),
      ),
    );
  }

  GestureDetector graphContainer(
      {required String imageGraphPath,
      required String label,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 297,
        height: 275,
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: backgroundActiveButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 162,
              height: 140,
              decoration: ShapeDecoration(
                color: Color.fromRGBO(255, 245, 233, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
              child: Container(
                width: 110,
                height: 110,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageGraphPath),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Spacer(),
            // sectionBufferHeight(bufferSection: 30),
            Text(label, textAlign: TextAlign.center, style: kfont22w_400black())
          ],
        ),
      ),
    );
  }

  String getImagePathForGraphType(String graphType) {
    switch (graphType) {
      case 'barChart':
        return barChartPath;
      case 'pieChart':
        return pieChartPath;
      case 'webChart':
        return webChartPath;
      case 'linearChart':
        return linearChartPath;
      default:
        return ''; // Provide a default image path or handle this case accordingly
    }
  }
}
