import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'gsy_list_state.dart';
import 'gsy_sliver_header_delegate.dart';
import 'nested_refresh.dart';

/**
 * Created by guoshuyu
 * Date: 2018-08-30
 */

abstract class BasePersonState<T extends StatefulWidget> extends State<T>
    with
        AutomaticKeepAliveClientMixin<T>,
        GSYListState<T>,
        SingleTickerProviderStateMixin {
  final GlobalKey<NestedScrollViewRefreshIndicatorState> refreshIKey =
      new GlobalKey<NestedScrollViewRefreshIndicatorState>();

  final List<String> orgList = new List();

  @override
  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      refreshIKey.currentState.show().then((e) {});
      return true;
    });
  }

  @protected
  renderItem(index, String beStaredCount, Color notifyColor,
      VoidCallback refreshCallBack, List<String> orgList) {
    return Container(
      height: 80,
      width: 200,
      color: Colors.lightGreenAccent,
      child: Text(
        orgList[index],
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    );

  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  @override
  bool get needHeader => true;

  @protected
  List<Widget> sliverBuilder(BuildContext context, bool innerBoxIsScrolled,
      Color notifyColor, String beStaredCount, refreshCallBack) {
    double headerSize = 810;
    double bottomSize = 70;
    return <Widget>[
      ///头部信息
      SliverPersistentHeader(
        pinned: true,
        delegate: GSYSliverHeaderDelegate(
            maxHeight: headerSize,
            minHeight: headerSize,
            changeSize: true,
            snapConfig: FloatingHeaderSnapConfiguration(
              vsync: this,
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 10),
            ),
            builder: (BuildContext context, double shrinkOffset,
                bool overlapsContent) {
              return Transform.translate(
                  offset: Offset(0, -shrinkOffset),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          height: 100,
                          color: Colors.red,
                        ),
                        onTap: () => {print('332342')},
                        behavior: HitTestBehavior.opaque,
                      ),
                      Container(
                        height: 210,
                        color: Colors.redAccent,
                      ),
                      Container(
                        height: 300,
                        color: Colors.amberAccent,
                      ),
                      Container(
                        height: 200,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ));
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
              var radius = Radius.circular(10 - shrinkOffset / bottomSize * 10);
              return SizedBox.expand(
                child: Padding(
                  padding: EdgeInsets.only(left: 0, right: 0),
                  child: Container(
                    height: 100,
                    color: Colors.pinkAccent,
                  ),

                  /// MultiProvider 共享 HonorModel 状态
//                  child: MultiProvider(
//                    providers: [
//                      ChangeNotifierProvider(create: (_) => honorModel),
//                    ],
//                    child: Consumer<HonorModel>(
//                      builder: (context, honorModel, _) {
//                        return UserHeaderBottom(
//                            userInfo,
//                            honorModel.beStaredCount?.toString() ?? "---",
//                            radius,
//                            honorModel.honorList);
//                      },
//                    ),
//                  ),
                ),
              );
            }),
      ),
    ];
  }

  @protected
  getUserOrg(bool loadmore) {
    var list = List<String>();
    for (int i = 0; i < 20; i++) {
      list.add('我是第$i');
    }
    if(loadmore) {
      page++;

    }
    if (page <= 1) {
      setState(() {
        orgList.clear();
        orgList.addAll(list);
        pullLoadWidgetControl.dataList.addAll(list);

      });
    }
    if(loadmore) {
      setState(() {
        pullLoadWidgetControl.dataList.addAll(list);

      });
    }
  }

//  Future<List<String>> mockNetworkData() async {
//    var list = List();
//    for (int i = 0; i < 10; i++) {
//      list.add('我是第$i');
//    }
//    return Future.delayed(Duration(seconds: 2), () => list);
//
//    //return Future.delayed(Duration(seconds: 2), () => {});
//  }
}
