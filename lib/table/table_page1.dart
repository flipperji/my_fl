import 'package:flutter/material.dart';
import 'package:my_fl/table/data_home_table1.dart';

import 'data_home_table.dart';

class TablePage1 extends StatefulWidget {
  TablePage1({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TablePage1State createState() => _TablePage1State();
}

class _TablePage1State extends State<TablePage1> {
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;
  ScrollController rightScrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();
  OuterSyncScrollControllerManager _syncScroller = OuterSyncScrollControllerManager();

  @override
  void initState() {
    user.initData(100);
    super.initState();
    _syncScroller
        .registerScrollController(scrollController1);
    _syncScroller
        .registerScrollController(scrollController2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表格'),
      ),
      body: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0),
              child: _getTitleItemWidget(
                  'Name' +
                      (sortType == sortName ? (isAscending ? '↓' : '↑') : ''),
                  100),
              onPressed: () {
                sortType = sortName;
                isAscending = !isAscending;
                user.sortName(isAscending);
                setState(() {});
              },
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.deepPurpleAccent,
                    child: Row(
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          child: _getTitleItemWidget(
                              'Status' +
                                  (sortType == sortStatus
                                      ? (isAscending ? '↓' : '↑')
                                      : ''),
                              100),
                          onPressed: () {
                            sortType = sortStatus;
                            isAscending = !isAscending;
                            user.sortStatus(isAscending);
                            setState(() {});
                          },
                        ),
                        _getTitleItemWidget('Phone', 200),
                        _getTitleItemWidget('Register', 100),
                        _getTitleItemWidget('Termination', 200),
                      ],
                    ),
                    width: 600,
                  ),
                  scrollDirection: Axis.horizontal,
                  controller: scrollController1,
                ),
                onNotification: (ScrollNotification scrollInfo) {
                  _syncScroller.processNotification(scrollInfo, scrollController1);
                  return false;
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            child: HorizontalDataTable1(
              outerSyncScroller: _syncScroller,
              outerScrollController: scrollController2,
              leftHandSideColumnWidth: 100,
              rightHandSideColumnWidth: 600,
              isFixedHeader: true,
              headerWidgets: _getTitleWidget(),
              leftSideItemBuilder: _generateFirstColumnRow,
              rightSideItemBuilder: _generateRightHandSideColumnRow,
              itemCount: user.userInfo.length,
              rowSeparatorWidget: const Divider(
                color: Colors.black54,
                height: 1.0,
                thickness: 0.0,
              ),
              leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
              rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
            ),
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ],
    );
  }


  Widget _getTestWidget(){
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            height: 88,
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 88,
                  color: Color(0xFFF3E5F5),
                ),
                Container(
                  width: 200,
                  height: 88,
                  color: Color(0xFFCE93D8),
                ),
                Container(
                  width: 200,
                  height: 88,
                  color: Color(0xFFAB47BC),
                ),
                Container(
                  width: 100,
                  height: 88,
                  color: Color(0xFF7B1FA2),
                ),
                Container(
                  width: 200,
                  height: 88,
                  color: Color(0xFF4A148C),
                ),
              ],
            ),
          ),
          scrollDirection: Axis.horizontal,
          controller: rightScrollController,
        ),
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification info){
            rightScrollController.jumpTo(info.metrics.pixels);
            return false;
          },
          child: SingleChildScrollView(
            child: Container(
              height: 88,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 88,
                    color: Color(0xFFF3E5F5),
                  ),
                  Container(
                    width: 200,
                    height: 88,
                    color: Color(0xFFCE93D8),
                  ),
                  Container(
                    width: 200,
                    height: 88,
                    color: Color(0xFFAB47BC),
                  ),
                  Container(
                    width: 100,
                    height: 88,
                    color: Color(0xFF7B1FA2),
                  ),
                  Container(
                    width: 200,
                    height: 88,
                    color: Color(0xFF4A148C),
                  ),
                ],
              ),
            ),
            scrollDirection: Axis.horizontal,
          ),
        ),

      ],
    );
  }

  Widget _getTestWidget2(){
    return  Column(
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          child: SingleChildScrollView(
            child: Container(
              height: 88,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 88,
                    color: Color(0xFFF3E5F5),
                  ),
                  Container(
                    width: 200,
                    height: 88,
                    color: Color(0xFFCE93D8),
                  ),
                  Container(
                    width: 200,
                    height: 88,
                    color: Color(0xFFAB47BC),
                  ),
                  Container(
                    width: 100,
                    height: 88,
                    color: Color(0xFF7B1FA2),
                  ),
                  Container(
                    width: 200,
                    height: 88,
                    color: Color(0xFF4A148C),
                  ),
                ],
              ),
            ),
            scrollDirection: Axis.horizontal,
            controller: scrollController1,
          ),
          onNotification: (ScrollNotification scrollInfo) {
            _syncScroller.processNotification(scrollInfo, scrollController1);
            return false;
          },
        ),
        NotificationListener<ScrollNotification>(
          child: SingleChildScrollView(
            child: Container(
              height: 88,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 88,
                    color: Color(0xFFF3E5F5),
                  ),
                  Container(
                    width: 200,
                    height: 88,
                    color: Color(0xFFCE93D8),
                  ),
                  Container(
                    width: 200,
                    height: 88,
                    color: Color(0xFFAB47BC),
                  ),
                  Container(
                    width: 100,
                    height: 88,
                    color: Color(0xFF7B1FA2),
                  ),
                  Container(
                    width: 200,
                    height: 88,
                    color: Color(0xFF4A148C),
                  ),
                ],
              ),
            ),
            scrollDirection: Axis.horizontal,
            controller: scrollController2,
          ),
          onNotification: (ScrollNotification scrollInfo) {
            _syncScroller.processNotification(scrollInfo, scrollController2);
            return false;
          },
        ),
      ],
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget(
            'Name' + (sortType == sortName ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortName;
          isAscending = !isAscending;
          user.sortName(isAscending);
          setState(() {});
        },
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget(
            'Status' +
                (sortType == sortStatus ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortStatus;
          isAscending = !isAscending;
          user.sortStatus(isAscending);
          setState(() {});
        },
      ),
      _getTitleItemWidget('Phone', 200),
      _getTitleItemWidget('Register', 100),
      _getTitleItemWidget('Termination', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(user.userInfo[index].name),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                  user.userInfo[index].status
                      ? Icons.notifications_off
                      : Icons.notifications_active,
                  color:
                      user.userInfo[index].status ? Colors.red : Colors.green),
              Text(user.userInfo[index].status ? 'Disabled' : 'Active')
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(user.userInfo[index].phone),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(user.userInfo[index].registerDate),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(user.userInfo[index].terminationDate),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}

User user = User();

class User {
  List<UserInfo> _userInfo = List<UserInfo>();

  void initData(int size) {
    for (int i = 0; i < size; i++) {
      _userInfo.add(UserInfo(
          "User_$i", i % 3 == 0, '+001 9999 9999', '2019-01-01', 'N/A'));
    }
  }

  List<UserInfo> get userInfo => _userInfo;

  set userInfo(List<UserInfo> value) {
    _userInfo = value;
  }

  ///
  /// Single sort, sort Name's id
  void sortName(bool isAscending) {
    _userInfo.sort((a, b) {
      int aId = int.tryParse(a.name.replaceFirst('User_', ''));
      int bId = int.tryParse(b.name.replaceFirst('User_', ''));
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortStatus(bool isAscending) {
    _userInfo.sort((a, b) {
      if (a.status == b.status) {
        int aId = int.tryParse(a.name.replaceFirst('User_', ''));
        int bId = int.tryParse(b.name.replaceFirst('User_', ''));
        return (aId - bId);
      } else if (a.status) {
        return isAscending ? 1 : -1;
      } else {
        return isAscending ? -1 : 1;
      }
    });
  }
}

class UserInfo {
  String name;
  bool status;
  String phone;
  String registerDate;
  String terminationDate;

  UserInfo(this.name, this.status, this.phone, this.registerDate,
      this.terminationDate);
}


class OuterSyncScrollControllerManager {
  List<ScrollController> _registeredScrollControllers =
  new List<ScrollController>();

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  void registerScrollController(ScrollController controller) {
    _registeredScrollControllers.add(controller);
  }

  void unregisterScrollController(ScrollController controller) {
    _registeredScrollControllers.remove(controller);
  }

  void processNotification(
      ScrollNotification notification, ScrollController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        _registeredScrollControllers.forEach((controller) {
          if (!identical(_scrollingController, controller)) {
            if (controller.hasClients) {
              controller.jumpTo(_scrollingController.offset);
            } else {}
          }
        });
        return;
      }
    }
  }
}