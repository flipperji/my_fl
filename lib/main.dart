import 'package:flutter/material.dart';

import 'calender/calendar_page.dart';
import 'chart/line_chart_sample5.dart';
import 'chart/line_chart_sample_test.dart';
import 'chart/liner_chart.dart';
import 'data/data_page.dart';
import 'nested/person_page.dart';
import 'table/data_home_table.dart';
import 'table/table_page.dart';
import 'table/table_page1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 120,left: 20,right: 20),
          child: CalendarPage(),
        ),
      ),
    );
  }
}
