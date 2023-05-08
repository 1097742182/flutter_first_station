import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first_station/paper/conform_dialog.dart';

import 'model.dart';
import 'paper_app_bar.dart';

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  List<Line> _lines = []; // 线列表

  int _activeColorIndex = 0; // 颜色激活索引
  int _activeStorkWidthIndex = 0; // 线宽激活索引

  // 支持的颜色
  final List<Color> supportColors = [
    Colors.black, Colors.red, Colors.orange,
    Colors.yellow, Colors.green, Colors.blue,
    Colors.indigo, Colors.purple,
  ];

  // 支持的线粗
  final List<double> supportStorkWidths = [1,2, 4, 6, 8, 10];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaperAppBar(
        onClear: _showClearDialog,
      ),
      body: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        child: CustomPaint(
          painter: PaperPainter(
            lines: _lines
          ),
          child: ConstrainedBox(constraints: const BoxConstraints.expand()),
        ),
      ),
    );
  }

  void _showClearDialog() {
    String msg = "您的当前操作会清空绘制内容，是否确定删除!";
    showDialog(
        context: context,
        builder: (ctx) => ConformDialog(
          title: '清空提示',
          conformText: '确定',
          msg: msg,
          onConform: _clear,
        ));
  }

  void _clear(){
    _lines.clear();
    Navigator.of(context).pop();
    setState(() {

    });
  }

  void _onPanStart(DragStartDetails details) {
    _lines.add(Line(points: [details.localPosition],));
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _lines.last.points.add(details.localPosition);
    setState(() {

    });
  }
}

class PaperPainter extends CustomPainter {
  PaperPainter({
    required this.lines,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  late Paint _paint;
  final List<Line> lines;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  ///根据点位绘制线
  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
