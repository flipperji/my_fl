import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSampleTest extends StatelessWidget {
  final List<int> showIndexes = const [1, 3, 5];
  final List<FlSpot> allSpots = [
    FlSpot(0, 0),
    FlSpot(1, 2),
    FlSpot(2, 1.5),
    FlSpot(3, 3),
    FlSpot(4, 3.5),
    FlSpot(5, 5),
    FlSpot(6, 4),
    FlSpot(7, 5),
    FlSpot(8, 3.4),
    FlSpot(9, 6),
    FlSpot(10, 7.8),
    FlSpot(11, 3),
    FlSpot(12, 1),
    FlSpot(13, 10),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 1000,
        height: 300,
        child: LineChart(
          mainData(),
          swapAnimationDuration: Duration(milliseconds: 0),
        ),
      ),
    );
  }

  List<Color> gradientColors = [
    const Color(0xFF3655E6),
  ];
  LineChartData mainData() {
    List<LineChartBarData> list = List();
    LineChartBarData thisMonthChartData = LineChartBarData(
      spots: allSpots,
      isCurved: false,
      colors: gradientColors,
      barWidth:2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Color(0xFF3655E6).withOpacity(0.2),
          Color(0xFF3655E6).withOpacity(0.0),
        ],
        gradientColorStops: [0.2, 1.0],
        gradientFrom: const Offset(0, 0),
        gradientTo: const Offset(0, 1),
      ),
    );
    list.add(thisMonthChartData);

    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(color: Color(0xFF666666), fontSize: 10),
          margin: 8,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '01:00';
              case 2:
                return '02:00';
              case 3:
                return '03:00';
              case 4:
                return '04:00';
              case 5:
                return '05:00';
              case 6:
                return '06:00';
              case 7:
                return '07:00';
              case 8:
                return '08:00';
              case 9:
                return '09:00';
              case 10:
                return '10:00';
              case 11:
                return '11:00';
              case 12:
                return '12:00';
              case 13:
                return '13:00';
              case 14:
                return '14:00';
              case 15:
                return '15:00';
              case 16:
                return '16:00';
              case 17:
                return '17:00';
              case 18:
                return '18:00';
              case 19:
                return '19:00';
              case 20:
                return '20:00';
              case 21:
                return '21:00';
              case 22:
                return '22:00';
              case 23:
                return '23:00';
              case 24:
                return '24:00';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
          textStyle: const TextStyle(
            color: Color(0xFF666666),
            fontSize: 10,
          ),
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
        horizontalInterval: 2,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xff999999),
            strokeWidth: 0.5,
            dashArray: [4],
          );
        },
      ),
      minX: 0,
      maxX: 24,
      minY: 0,
      maxY: 10.1,
      lineBarsData: list,
      lineTouchData: LineTouchData(
          fullHeightTouchLine: true,
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((spotIndex) {
              final FlSpot spot = barData.spots[spotIndex];
              return TouchedSpotIndicatorData(
                FlLine(color: Color(0xFF333333), strokeWidth:1),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 2,
                      color: Colors.transparent,
                      strokeColor: Colors.transparent,
                      strokeWidth: 0.5,
                    );
                  },
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              tooltipBgColor: Color(0xB3FFFFFF),
              tooltipRoundedRadius: 4,
              tooltipPadding: EdgeInsets.only(
                  left: 12,
                  top: 3,
                  right: 12,
                  bottom: 3),
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  print('-------------${barSpot.x}-----');
                  return LineTooltipItem(
                   barSpot.y.toString(),
                    const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 10,
                    ),
                  );
                }).toList();
              })),
    );
  }
}


