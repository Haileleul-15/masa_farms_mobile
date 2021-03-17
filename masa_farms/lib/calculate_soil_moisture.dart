import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

calculateSoilMoisture(longitude, latitude) {
  var soilMoisture;

  soilMoisture = (0.5 * longitude) + (-0.8 * latitude);

  return soilMoisture;
}

class SoilMoisture extends StatefulWidget {
  SoilMoisture({this.app});
  final FirebaseApp app;
  @override
  _SoilMoistureState createState() => _SoilMoistureState();
}

class _SoilMoistureState extends State<SoilMoisture> {
  final referenceDatabase = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
