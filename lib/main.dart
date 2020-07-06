import 'package:flutter/material.dart';

import 'data/data_page.dart';
import 'nested/person_page.dart';
import 'table/data_home_table.dart';
import 'table/table_page.dart';

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
      home: TablePage(),
    );
  }
}


