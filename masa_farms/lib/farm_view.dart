import 'dart:ui';
import 'package:flutter/material.dart';
import 'calculate_soil_moisture.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FarmView extends StatefulWidget {
  FarmView({this.app});
  final FirebaseApp app;
  @override
  _FarmViewState createState() => _FarmViewState();
}

class _FarmViewState extends State<FarmView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 450,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: CustomPaint(
              painter: FarmPainter(),
            )));
  }
}

class FarmPainter extends CustomPainter {
  final referenceDatabase = FirebaseDatabase.instance.reference();

  void addData() {
    referenceDatabase.child('test').set('Haile');
  }

  Color getColor(soilMoisture) {
    Color color;
    if (soilMoisture > -360 && soilMoisture < -200) {
      color = Colors.blueAccent;
    } else if (soilMoisture > -200 && soilMoisture < -100) {
      color = Colors.lightBlueAccent;
    } else if (soilMoisture > -100 && soilMoisture < 0) {
      color = Colors.blue;
    } else {
      color = Colors.red;
    }

    return color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    addData();
    var points = [];
    var soilMoistureValues = [];
    // var points = [];
    // var inputs = [];

    // for (double i = 0; i < 150; i++) {
    //   points.add(Offset(0 + i, 0));
    //   inputs.add([0 + i, 0]);
    //   for (double j = 0; j < 450; j++) {
    //     points.add(Offset(0 + i, 0 + j));
    //     inputs.add([0 + i, 0 + j]);
    //   }
    // }
    // points = points.cast<Offset>();
    // print(inputs);

    Paint background = Paint()..color = Colors.greenAccent;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // var paint = Paint()
    //   ..color = getColor(1)
    //   ..strokeCap = StrokeCap.round
    //   ..strokeWidth = 5;

    canvas.drawRect(rect, background);
    for (double i = 0; i < 300; i++) {
      for (double j = 0; j < 450; j++) {
        var soilMoisture = calculateSoilMoisture(i, j);
        soilMoistureValues.add(soilMoisture);
        points.add(Offset(0 + i, 0 + j));
        points = points.cast<Offset>();

        var paint = Paint()
          ..color = getColor(soilMoisture)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 10;

        canvas.drawPoints(PointMode.points, points, paint);
        points.clear();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
