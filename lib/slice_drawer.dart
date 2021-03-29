import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart_data.dart';

abstract class SliceDrawer {

  void drawSlice({Canvas canvas, Size area, double startAngle, double sweepAngle,
    Slice slice, bool rounded});

}
