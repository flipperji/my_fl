import 'package:flutter/material.dart';

import 'flutter_time_axis.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {

  var list = [
    '大翻领大发啦减肥大法的',
    'dalf大家法兰多拉放大了负担弗拉索夫垃圾领导发牢骚法律啦减肥乐山大佛缩放啊',
    '大翻领大发啦减肥大法的dalf大家法兰多拉放大了负担弗拉索夫垃圾领导发牢骚法律啦减肥乐山大佛缩放啊',
    '大翻领大发啦减肥大法的',
    '大翻领大发啦减肥大法的dalf大家法兰多拉放大了负担弗拉索夫垃圾领导发牢骚法律啦减肥乐山大佛缩放啊大翻领大发啦减肥大法的dalf大家法兰多拉放大了负担弗拉索夫垃圾领导发牢骚法律啦减肥乐山大佛缩放啊',
  ];

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return PaintCirLineItem(
            30,
            index,
            timeAxisLineWidth: 1,
            contentWight: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(
                          '${list[index]}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '未完成',
                      style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 14,
                          height: 1
                      ),
                    )
                  ],
                ),
                index != 1
                    ? SizedBox(
                  height: 71,
                )
                    : Container(
                  width: 180,
                  height: 180,
                  margin: EdgeInsets.only(
                    bottom: 50,
                  ),
                  color: Colors.tealAccent,
                ),
              ],
            ),
            leftLineColor: Colors.red,
            contentLeft: 32,
            leftWidget: Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border:
                    Border.all(width: 2, color: Color(0xFF3655E6)))),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
