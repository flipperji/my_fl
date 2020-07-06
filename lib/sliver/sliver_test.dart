import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'gsy_sliver_header_delegate.dart';

class SliverTestPage extends StatefulWidget {
  @override
  _SliverTestPageState createState() => _SliverTestPageState();
}

class _SliverTestPageState extends State<SliverTestPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: ScrollController(),
      // ignore: missing_return
      headerSliverBuilder: sliverBuilder,
      body: Container(
        color: Colors.redAccent,
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              color: Colors.tealAccent,
            ),
            ListView.builder(itemBuilder: (context,index){
              return Text('第${index}个');

            })
          ],
        ),
      ),
    );
  }

  List<Widget> sliverBuilder(BuildContext context,bool innerBoxIsScrolled) {
    double headerSize = 210;
    double bottomSize = 70;
    return <Widget>[
      ///头部信息
      SliverPersistentHeader(
        pinned: true,
        delegate: GSYSliverHeaderDelegate(
            maxHeight: 600,
            minHeight: 0,
            changeSize: false,
            snapConfig: FloatingHeaderSnapConfiguration(
              vsync: this,
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 10),
            ),
            builder: (BuildContext context, double shrinkOffset,
                bool overlapsContent) {
              return Transform.translate(
                offset: Offset(0, -shrinkOffset),
                child: SizedBox.expand(
                  child: Container(
                    width: 600,
                    height: 150,
                    color: Colors.lightBlue,
                  ),
                ),
              );
            }),
      ),

      ///悬停的item
      SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: GSYSliverHeaderDelegate(
            maxHeight: bottomSize,
            minHeight: bottomSize,
            changeSize: true,
            snapConfig: FloatingHeaderSnapConfiguration(
              vsync: this,
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 10),
            ),
            builder: (BuildContext context, double shrinkOffset,
                bool overlapsContent) {
              return Container(
                height: 100,
                color: Colors.deepPurpleAccent,
              );
            }),
      ),

      ///提交图表
//      SliverPersistentHeader(
//        delegate: GSYSliverHeaderDelegate(
//            maxHeight: 400,
//            minHeight: 400,
//            changeSize: true,
//            snapConfig: FloatingHeaderSnapConfiguration(
//              vsync: this,
//              curve: Curves.bounceInOut,
//              duration: const Duration(milliseconds: 10),
//            ),
//            builder: (BuildContext context, double shrinkOffset,
//                bool overlapsContent) {
//              return ListView.builder(itemBuilder: (context,index){
//                return Text('第$index个');
//              });
//            }),
//      ),
    ];
  }
}
