import 'dart:ffi';

import 'package:jeetbmi/DB/databaseinit.dart';
import 'package:jeetbmi/asset/string.dart';
import 'package:jeetbmi/model/chartModel.dart';
import 'package:jeetbmi/screen/daily.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class userhome extends StatefulWidget {
  const userhome({super.key});

  @override
  State<userhome> createState() => _userhomeState();
}

class _userhomeState extends State<userhome> {
  late double bmi;
  late String userName;
  bool datalodaed = false;
  late List<ChartModel> chartData;
  bool ischartLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUSer();
    getDatafromDBforChart();
  }

  Future getDatafromDBforChart() async {
    ischartLoaded = false;
    List<Map<String, dynamic>> userDataList =
        await DatabaseHelper().getRecords();
    chartData = userDataList.map((map) {
      return ChartModel(
        int.parse(
          map["date"].substring(9, 11),
        ),
        map["weight"].toDouble(),
      );
    }).toList();
    print(chartData[0].date);
    ischartLoaded = true;
    setState(() {});
  }

  Future getUSer() async {
    SharedPreferences preferce = await SharedPreferences.getInstance();
    userName = await preferce.getString(AppString.spName).toString();
    bmi = int.parse(await preferce.getString("${AppString.spHeight}")!) /
        (int.parse(await preferce.getString("${AppString.spHeight}")!) *
            int.parse(await preferce.getString("${AppString.spWeight}")!));
    setState(() {
      datalodaed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(AppString.homepagetitle),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CalendarPickerDemo()));
              },
              icon: const Icon(Icons.menu),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(userName),
                    const Icon(Icons.person),
                  ],
                ),
              )
            ]),
        body: Column(
          children: [
            datalodaed
                ? Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: FittedBox(
                            child: Text(
                              AppString.yourBMIheading,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        // Optional: Add a divider line between heading and title
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: FittedBox(
                            child: Text(
                              bmi.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
            ischartLoaded
                ?
                // Text("${chartData.length}")

                Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23)),
                        child: Center(
                          child: Text(
                            AppString.weightChartTitle,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height/3,
                          width: MediaQuery.of(context).size.width,
                          child: BarChart(
                            BarChartData(
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(color: const Color(0xff37434d), width: 1),
                              ),
                              titlesData: FlTitlesData(),
                              barGroups: chartData
                                  .asMap()
                                  .entries
                                  .map((entry) => BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(fromY: entry.value.weight, color: Colors.blue, toY:entry.value.date.toDouble())
                                ],
                              ))
                                  .toList(),
                            ),
                          )
                        ),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(),
            ElevatedButton(
              onPressed: () {
                getDatafromDBforChart();
              },
              child:  Text(AppString.weightChartRefresh),
            )
          ],
        ),
      ),
    );
  }
}
