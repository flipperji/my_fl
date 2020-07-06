import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_fl/chart/line_chart_sample4.dart';
import 'package:my_fl/chart/line_chart_sample5.dart';
import 'package:my_fl/chart/line_chart_sample6.dart';
import 'package:my_fl/chart/line_chart_sample7.dart';

import 'line_chart_sample1.dart';
import 'line_chart_sample2.dart';
import 'line_chart_sample3.dart';

class LinearChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100, bottom: 100),
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return LineChartSample1();
          } else if (index == 1) {
            return LineChartSample2();
          } else if (index == 2) {
            return LineChartSample3();
          } else if (index == 3) {
            return LineChartSample4();
          } else if (index == 4) {
            return LineChartSample5();
          } else if (index == 5) {
            return LineChartSample6();
          } else if (index == 6) {
            return LineChartSample7();
          } else {
            return Container(
              height: 200,
              child: LineChart(mainData()),
            );
          }
        },
        itemCount: 8,
      ),
    );
  }
}

List<Color> gradientColors = [
  const Color(0xFF3655E6),
];

LineChartData mainData() {
  return LineChartData(
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 20,
        textStyle: const TextStyle(color: Color(0xFF666666), fontSize: 10),
        margin: 8,
        getTitles: (value) {
          if (value.toInt() % 5 == 0) {
            return value.toInt().toString();
          }
          return '';
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        interval: 280,
        textStyle: const TextStyle(
          color: Color(0xFF666666),
          fontSize: 10,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 280:
              return '280';
            case 560:
              return '560';
            case 840:
              return '840';
            case 1120:
              return '1120';
            case 1400:
              return '1400';
          }
          print('sssss   $value  sssssss');
          return '';
        },
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border(
        bottom: BorderSide(
          color: const Color(0xff999999),
          width: 1,
        ),
      ),
    ),
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      horizontalInterval: 280,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Color(0xff999999),
          strokeWidth: 0.5,
          dashArray: [4],
        );
      },
    ),
    minX: 1,
    maxX: 31,
    minY: 0,
    maxY: 1401,
    lineBarsData: linesBarData1(),
    lineTouchData: LineTouchData(
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            final FlSpot spot = barData.spots[spotIndex];
            if (spot.x == 0) {
              return null;
            }
            return TouchedSpotIndicatorData(
              FlLine(color: Color(0xFF3655E6), strokeWidth: 0.5),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 3,
                    color: Color(0xFF333333),
                  );
                },
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            tooltipBgColor: Colors.white,
            tooltipPadding:
                EdgeInsets.only(left: 12, top: 3, right: 12, bottom: 3),
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                if (flSpot.x == 0 || flSpot.x == 6) {
                  return null;
                }
                return LineTooltipItem(
                  '${flSpot.y} k calories',
                  const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 10,
                  ),
                );
              }).toList();
            })),
  );
}

List<LineChartBarData> linesBarData1() {
  final LineChartBarData lineChartBarData1 = LineChartBarData(
    spots: [
      FlSpot(1, 422),
      FlSpot(2, 1316),
      FlSpot(3, 322),
      FlSpot(4, 633),
      FlSpot(5, 118),
      FlSpot(6, 833),
    ],
    isCurved: true,
    colors: gradientColors,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: true,
      colors: [
        Color(0xFF3655E6).withOpacity(0.6),
        Color(0xFF3655E6).withOpacity(0.0),
      ],
      gradientColorStops: [0.5, 1.0],
      gradientFrom: const Offset(0, 0),
      gradientTo: const Offset(0, 1),
    ),
  );
  return [
    lineChartBarData1,
  ];
}
