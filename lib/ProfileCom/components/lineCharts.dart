import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Styles/Colors.dart';

class LineCharts extends StatefulWidget {
  const LineCharts({super.key});

  @override
  State<LineCharts> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineCharts> {
  List<Color> gradientColors = [
    purpleColor,
    purpleColor,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.70,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Янв', style: style);
        break;
      // case 1:
      //   text = const Text('Фев', style: style);
      //   break;
      case 2:
        text = const Text('Мар', style: style);
        break;
      // case 3:
      //   text = const Text('Апр', style: style);
      //   break;
      case 4:
        text = const Text('Май', style: style);
        break;
      // case 5:
      //   text = const Text('Июнь', style: style);
      //   break;
      case 6:
        text = const Text('Июл', style: style);
        break;
      // case 7:
      //   text = const Text('Авг', style: style);
      //   break;
      case 8:
        text = const Text('Сен', style: style);
        break;
      // case 9:
      //   text = const Text('Окт', style: style);
      //   break;
      case 10:
        text = const Text('Ноя', style: style);
        break;
      // case 11:
      //   text = const Text('Дек', style: style);
      //   break;
      default:
        return SizedBox();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 5:
        text = '5';
        break;
      case 10:
        text = '10';
        break;
      case 15:
        text = '15';
        break;
      default:
        return SizedBox();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchSpotThreshold: 11,
        touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
          return touchedBarSpots.map((barSpot) {
            return LineTooltipItem(
              "${barSpot.y.toInt()}",
              TextStyle(color: Colors.white),
            );
          }).toList();
        }),
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              FlLine(color: purpleColor, strokeWidth: 3),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                      strokeColor: purpleColor, radius: 3, color: purpleColor);
                },
              ),
            );
          }).toList();
        },
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(show: false
          // show: true,
          // border: Border.all(color: const Color(0xff37434d)),
          ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 15,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 0),
            FlSpot(1, 0),
            FlSpot(2, 0),
            FlSpot(3, 0),
            FlSpot(4, 0),
            FlSpot(5, 0),
            FlSpot(6, 0),
            FlSpot(7, 0),
            FlSpot(8, 0),
            FlSpot(9, 0),
            FlSpot(10, 0),
            FlSpot(11, 0),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
