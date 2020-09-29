import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart_data.dart';
import 'package:pie_chart/pie_chart_painter.dart';
import 'package:pie_chart/simple_slice_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  List<Slice> list;
  PieChartData data;


  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));

    controller.forward();
    list = [
      Slice(value: randomLength(), color: randomColor()),
      Slice(value: randomLength(), color: randomColor()),
      Slice(value: randomLength(), color: randomColor()),
    ];
    data = PieChartData(slices: list);
  }

  double _sliceThickness = 25;

  void addSlice() {
    list.add(Slice(value: randomLength(), color: randomColor()));
  }

  void removeSlice() {
    colors.add(list.last.color);
    list.removeLast();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Center(
                  child: CustomPaint(
                    painter: PieChartPainter(
                        sliceDrawer:
                            SimpleSliceDrawer(sliceThickness: _sliceThickness),
                        pieChartData: data,
                        progress: animation.value),
                    child: Container(
                      width: 200,
                      height: 200,
                    ),
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Thickness: '),
                  Expanded(
                    child: Slider(
                      value: _sliceThickness,
                      onChanged: (val) {
                        setState(() {
                          _sliceThickness = val.toDouble();
                        });
                      },
                      min: 10,
                      max: 100,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  list.length > 3
                      ? RaisedButton(
                          onPressed: () {
                            setState(() {
                              removeSlice();
                            });
                          },
                          color: Colors.blue,
                          child: Text(
                            '-',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        )
                      : RaisedButton(
                          onPressed: () {},
                          child: Text(
                            '-',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                  Text('${list.length}'),
                  list.length >= 3 && list.length <= 9
                      ? RaisedButton(
                          onPressed: () {
                            setState(() {
                              addSlice();
                            });
                          },
                          color: Colors.blue,
                          child: Text(
                            '+',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        )
                      : RaisedButton(
                          onPressed: () {},
                          child: Text(
                            '+',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
