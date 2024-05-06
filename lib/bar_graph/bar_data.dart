import 'package:expenseguard/bar_graph/individual_bar.dart';
import 'package:flutter/material.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBar() {
    barData = [
      IndividualBar(
          x: 0, y: sunAmount, color: const Color.fromARGB(255, 105, 222, 214)),
      IndividualBar(
          x: 1, y: monAmount, color: const Color.fromARGB(255, 43, 170, 177)),
      IndividualBar(
          x: 2, y: tueAmount, color: const Color.fromARGB(255, 21, 157, 155)),
      IndividualBar(
          x: 3, y: wedAmount, color: const Color.fromARGB(255, 10, 110, 153)),
      IndividualBar(
          x: 4, y: thurAmount, color: const Color.fromARGB(255, 8, 134, 134)),
      IndividualBar(x: 5, y: friAmount, color: Color.fromARGB(255, 7, 93, 128)),
      IndividualBar(x: 6, y: satAmount, color: Color.fromARGB(255, 2, 84, 114)),
    ];
  }
}
