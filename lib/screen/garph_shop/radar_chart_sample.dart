import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool darkMode = false;
  bool useSides = true;
  double numberOfFeatures = 6;

  @override
  Widget build(BuildContext context) {
    const ticks = [7, 14, 21, 28, 35];
    var features = ["AA", "BB", "CC", "DD", "EE", "FF", "GG", "HH"];
    var data = [
      [10.0, 20, 28, 5, 16, 15, 17, 6],
      [14.5, 1, 4, 14, 23, 10, 6, 19]
    ];

    features = features.sublist(0, numberOfFeatures.floor());
    data = data
        .map((graph) => graph.sublist(0, numberOfFeatures.floor()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Radar CHART Example'),
      ),
      body: Container(
        color: darkMode ? Colors.black : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  darkMode
                      ? Text(
                          'Light mode',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          'Dark mode',
                          style: TextStyle(color: Colors.black),
                        ),
                  Switch(
                    value: this.darkMode,
                    onChanged: (value) {
                      setState(() {
                        darkMode = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  useSides
                      ? Text(
                          'Polygon border',
                          style: darkMode
                              ? TextStyle(color: Colors.white)
                              : TextStyle(color: Colors.black),
                        )
                      : Text(
                          'Circular border',
                          style: darkMode
                              ? TextStyle(color: Colors.white)
                              : TextStyle(color: Colors.black),
                        ),
                  Switch(
                    value: this.useSides,
                    onChanged: (value) {
                      setState(() {
                        useSides = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Number of features',
                    style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black),
                  ),
                  Expanded(
                    child: Slider(
                      value: this.numberOfFeatures,
                      min: 3,
                      max: 8,
                      divisions: 5,
                      onChanged: (value) {
                        setState(() {
                          numberOfFeatures = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: darkMode
                  ? RadarChart.dark(
                      ticks: ticks,
                      features: features,
                      data: data,
                      reverseAxis: true,
                      useSides: useSides,
                    )
                  : RadarChart.light(
                      ticks: ticks,
                      features: features,
                      data: data,
                      reverseAxis: true,
                      useSides: useSides,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
