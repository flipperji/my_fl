import 'dart:async';

import 'package:flutter/material.dart';

import 'base_person_state.dart';
import 'gsy_nested_pull_load_widget.dart';

/**
 * 个人详情
 * Created by guoshuyu
 * Date: 2018-07-18
 */
class PersonPage extends StatefulWidget {
  static final String sName = "person";


  PersonPage({Key key}) : super(key: key);

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends BasePersonState<PersonPage> {

  String beStaredCount = "---";

  bool focusStatus = false;

  String focus = "";
  final List<String> orgList = new List();

  _PersonState();


  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;

    ///获取网络用户数据


    ///获取用户动态或者组织成员

    getUserOrg(false);

    isLoading = false;

    ///获取当前用户的关注状态
    //_getFocusStatus();

    ///获取用户仓库前100个star统计数据
   // getHonor(_getUserName());

    return null;
  }


  @override
  bool get wantKeepAlive => true;

  @override
  requestRefresh() async {
    getUserOrg(false);
  }

  @override
  requestLoadMore() async {
    getUserOrg(true);

  }

  @override
  bool get isRefreshFirst => true;

  @override
  bool get needHeader => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
        appBar: AppBar(
          title: Text('这是标题'),
        ),
        body: GSYNestedPullLoadWidget(
          pullLoadWidgetControl,
          (BuildContext context, int index) =>
              renderItem(index, beStaredCount, null, null,orgList),
          handleRefresh,
          onLoadMore,
          refreshKey: refreshIKey,
          headerSliverBuilder: (context, _) {
            return sliverBuilder(
                context, _, null, beStaredCount, null);
          },
        ));
  }
}

class User{

}
