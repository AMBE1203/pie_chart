import 'package:flutter/material.dart';
import 'dart:math' as math;

const double degrees2Radians = math.pi / 180.0;

class PieChartData {
  List<Slice> slices;

  PieChartData({this.slices});

  double totalSize() => slices
      .map((e) => e.value)
      .toList()
      .reduce((value, element) => value + element);
}

class Slice {
  final double value;
  final Color color;

  Slice({this.value, this.color});
}

math.Random random = math.Random();
var colors = [
  Color(0XFFF44336),
  Color(0XFFE91E63),
  Color(0XFF9C27B0),
  Color(0XFF673AB7),
  Color(0XFF3F51B5),
  Color(0XFF03A9F4),
  Color(0XFF009688),
  Color(0XFFCDDC39),
  Color(0XFFFFC107),
  Color(0XFFFF5722),
  Color(0XFF795548),
  Color(0XFF9E9E9E),
  Color(0XFF607D8B)
];

double calculateAngle(
        {double sliceLength, double totalLength, double progress}) =>
    360 * (sliceLength * progress) / totalLength;

double radians(double degrees) => degrees * degrees2Radians;

double randomLength() => (10 * random.nextInt(9) + 10).toDouble();

Color randomColor() {
  var randomIndex = random.nextInt(colors.length).toInt();
  var color = colors[randomIndex];
  colors.removeAt(randomIndex);
  return color;
}
