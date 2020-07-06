import 'package:flutter/material.dart';
class MyPainter extends CustomPainter {
  double circleSize;
  Color lineColor;
  double paintWidth;
  MyPainter(
      {this.circleSize,
        this.lineColor = Colors.redAccent,this.paintWidth=4});

  Paint _paint = Paint()
    ..strokeCap = StrokeCap.square //画笔笔触类型
    ..isAntiAlias = true;//是否启动抗锯齿; //画笔的宽度
  Path _path = new Path();

  @override
  // ignore: missing_return
  Future paint(Canvas canvas, Size size) {
    _paint.style = PaintingStyle.stroke; // 画线模式
    _paint.color = this.lineColor;
    _paint.strokeWidth=this.paintWidth;
    _path.moveTo(circleSize, 1); // 移动起点到（20,40）
    _path.lineTo(circleSize, size.height); // 画条斜
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}