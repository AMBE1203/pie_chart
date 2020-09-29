import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart_data.dart';
import 'package:pie_chart/slice_drawer.dart';

class PieChartPainter extends CustomPainter {
  final PieChartData pieChartData;
  final double progress;
  final SliceDrawer sliceDrawer;

  PieChartPainter({this.sliceDrawer, this.pieChartData, this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    var slices = pieChartData.slices;
    double startArc = 0;

    slices.forEach((element) {

      var arc = calculateAngle(
          sliceLength: element.value,
          totalLength: pieChartData.totalSize(),
          progress: progress);
      
      
      sliceDrawer.drawSlice(
          canvas: canvas,
          area: size,
          startAngle: radians(startArc),
          sweepAngle: radians(arc),
          slice: element);

      startArc += arc;

    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
