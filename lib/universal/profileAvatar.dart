import 'dart:math';
import 'package:flutter/material.dart';

class ProfileAvatar extends CustomPainter {
  double xCircle, yCircle, xSquare, ySquare;
  static double randomValue;
  static bool isRootNegative;
  Random random;

  ProfileAvatar() {
    random = new Random();
    isRootNegative = isRootNegative ?? random.nextBool();
    randomValue = randomValue ?? random.nextDouble();
  }

  double getXaxisCircle(double width) {
    double value = width * randomValue;
    return value;
  }

  double getYaxisCircle(double xC, Size size) {
    final double r = (size.width / 2);
    final double g = (size.width / 2);
    final double h = (size.height / 2);
    double value = isRootNegative
        ? h + sqrt((pow(r, 2) - pow((xC - g), 2)))
        : h - sqrt((pow(r, 2) - pow((xC - g), 2)));
    return value;
  }

  double getXaxisSquare(double xC, double width) {
    final double minDiffX = (120 / 180) * width;
    double value = xC + minDiffX;
    return value % width;
  }

  double getYaxisSquare(double xS, Size size) {
    final double r = (size.width / 2);
    final double g = (size.width / 2);
    final double h = (size.height / 2);
    double value = isRootNegative
        ? h + sqrt((pow(r, 2) - pow((xS - g), 2)))
        : h - sqrt((pow(r, 2) - pow((xS - g), 2)));
    return value;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    xCircle = getXaxisCircle(size.width);
    yCircle = getYaxisCircle(xCircle, size);

    canvas.drawCircle(
      Offset(xCircle, yCircle),
      9,
      paint,
    );

    xSquare = getXaxisSquare(xCircle, size.width);
    ySquare = getYaxisSquare(xSquare, size);

    paint.color = Colors.green;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(xSquare, ySquare),
        height: 20,
        width: 20,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
