import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart_data.dart';
import 'package:pie_chart/slice_drawer.dart';

class SimpleSliceDrawer implements SliceDrawer {
  final sectionPaint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true;

  final double sliceThickness;

  SimpleSliceDrawer({this.sliceThickness = 25})
      : assert(sliceThickness <= 100 && sliceThickness >= 10);

  double calculateSectorThickness({Size area}) {
    var minSize = min(area.width, area.height);

    return minSize * (sliceThickness / 200);
  }

  Rect calculateDrawableArea({Size area}) {
    var sliceThicknessOffset = calculateSectorThickness(area: area) / 2;
    var offsetHorizontally = (area.width - area.height) / 2;

    return Rect.fromLTRB(
        sliceThicknessOffset + offsetHorizontally,
        sliceThicknessOffset,
        area.width - sliceThicknessOffset - offsetHorizontally,
        area.height - sliceThicknessOffset);
  }

  @override
  void drawSlice(
      {Canvas canvas,
      Size area,
      double startAngle,
      double sweepAngle,
      Slice slice,
      bool rounded}) {
    var sliceThickness = calculateSectorThickness(area: area);
    var drawableArea = calculateDrawableArea(area: area);
    if (rounded){
      sectionPaint..strokeCap = StrokeCap.round;
    }

    canvas.drawArc(
        drawableArea,
        startAngle,
        sweepAngle,
        false,
        sectionPaint
          ..color = slice.color
          ..strokeWidth = sliceThickness);
  }
}
