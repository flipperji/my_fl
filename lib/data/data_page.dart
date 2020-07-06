import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SmartRefresher(
              controller: _refreshController,
              enablePullUp: false,
              child: ListView(
                padding: EdgeInsets.zero,
                controller: _controller,
                children: <Widget>[
                  Opacity(
                    opacity: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          // 10% of the width, so there are ten blinds.
                          colors: [
                            const Color(0xFF4478FF),
                            const Color(0xFF2C4CE1)
                          ],
                          // whitish to gray
                          tileMode: TileMode
                              .clamp, // repeats the gradient over the canvas
                        ),
                      ),
                      height: 120,
                      padding: EdgeInsets.only(top: 45),
                      child: Text(
                        '这是标题',
                        style: TextStyle(fontSize: 21, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    color: Colors.pinkAccent,
                  ),
                  Container(
                    height: 200,
                    color: Colors.purpleAccent,
                  ),
                  Container(
                    height: 60,
                    color: Colors.tealAccent,
                  ),
                  Container(
                    height: 1000,
                    color: Colors.orangeAccent,
                  ),
                ],
              ),
              footer: ClassicFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
                completeDuration: Duration(milliseconds: 500),
              ),
              header: ClassicHeader(
                height: 60,
              ),
              onRefresh: () async {
                _refreshController.refreshCompleted();
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                height: 60,
                color: Colors.tealAccent,
              ),
            ),
          ],
        ),
    );
  }
}
