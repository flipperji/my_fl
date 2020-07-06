import 'package:flutter/material.dart';

import 'painter_cusotm.dart';

///[index]这个属性主要是为了给左边的时间轴画部件来用的 This attribute is primarily to the left of the timeline painted parts to use;
///[timeAxisSize]时间轴的大小必须要的。
///
///
///
///
///
///
///
///
class PaintCirLineItem extends StatefulWidget {
  int index;
  double timeAxisSize;
  double contentLeft;
  Widget leftWidget;
  double lineToLeft;
  double marginLeft;
  Color leftLineColor;
  Widget centerRightWidget;
  Widget centerLeftWidget;
  Widget contentWight;
  double timeAxisLineWidth;

  PaintCirLineItem(this.timeAxisSize, this.index,
      {this.contentLeft,
      this.leftWidget,
      this.lineToLeft,
      this.marginLeft = 5,
      this.leftLineColor,
      this.centerRightWidget,
      this.centerLeftWidget,
      this.contentWight,
      this.timeAxisLineWidth}) {
    if (lineToLeft == null) {
      this.lineToLeft = timeAxisSize / 2;
    }
    if (contentLeft == null) {
      this.contentLeft = lineToLeft + 3;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _PaintCirLineItemState();
  }
}

class _PaintCirLineItemState extends State<PaintCirLineItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: widget.marginLeft),
        child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: new MyPainter(
                paintWidth: widget.timeAxisLineWidth,
                circleSize: widget.lineToLeft,
                lineColor: widget.index != 2
                    ? widget.leftLineColor
                    : Colors.transparent,
              ),
              child: Container(
                padding: EdgeInsets.only(left: widget.contentLeft),
                child: Container(
                  child: widget.contentWight,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: widget.timeAxisSize,
                  child: widget.leftWidget,
                ),
              ],
            ),
          ],
        ));
  }
}
