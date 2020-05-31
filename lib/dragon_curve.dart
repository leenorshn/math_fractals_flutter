import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

class DragonPainter extends CustomPainter {
  int xStart, yStart, iteration;
  Color color;

  DragonPainter(this.xStart, this.yStart, this.iteration, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var turns = getSequence(iteration);

    var startingAngle = iteration * (pi / 4);
    var side = 400 / pow(2, iteration / 2.0);

    double angle = startingAngle;
    int x1 = xStart, y1 = yStart;
    int x2 = x1 + (cos(angle) * side).toInt();
    int y2 = y1 + (sin(angle) * side).toInt();
    var p1 = Offset(x1.toDouble(), y1.toDouble());
    var p2 = Offset(x2.toDouble(), y2.toDouble());
    canvas.drawLine(p1, p2, Paint()..color = Colors.white);
    x1 = x2;
    y1 = y2;
    for (int turn in turns) {
      Color c = color == Colors.transparent
          ? colors[Random().nextInt(colors.length)].color
          : color;
      angle += turn * (pi / 2);
      x2 = x1 + (cos(angle) * side).toInt();
      y2 = y1 + (sin(angle) * side).toInt();
      canvas.drawLine(Offset(x1.toDouble(), y1.toDouble()),
          Offset(x2.toDouble(), y2.toDouble()), Paint()..color = c);
      x1 = x2;
      y1 = y2;
    }
  }

  List<int> getSequence(int iterations) {
    List<int> turnSequence = List<int>();
    for (int i = 0; i < iterations; i++) {
      List<int> copy = turnSequence.reversed.toList();
      turnSequence.add(1);
      copy.forEach((element) {
        turnSequence.add(-element);
      });
    }
    return turnSequence;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

var colors = [
  ColorInfo("red", Colors.red, Colors.red[500].toString()),
  ColorInfo("green", Colors.green, Colors.green[500].toString()),
  ColorInfo("blue", Colors.blue, Colors.blue[500].toString()),
  ColorInfo("yellow", Colors.yellow, Colors.yellow[500].toString()),
  ColorInfo("purple", Colors.purple, Colors.purple[500].toString()),
  ColorInfo("amber", Colors.amber, Colors.amber[500].toString()),
  ColorInfo("cyan", Colors.cyan, Colors.cyan[500].toString()),
  ColorInfo("grey", Colors.grey, Colors.grey[500].toString()),
  ColorInfo("teal", Colors.teal, Colors.teal[500].toString()),
  ColorInfo("pink", Colors.pink, Colors.pink[500].toString()),
  ColorInfo("orange", Colors.orange, Colors.orange[500].toString()),
];

class ColorInfo {
  String name;
  MaterialColor color;
  String hex;

  ColorInfo(this.name, this.color, this.hex);
}

