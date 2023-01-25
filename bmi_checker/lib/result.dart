import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double height;
  final double weight;

  const ResultScreen({
    Key? key,
    required this.height,
    required this.weight,
  }) : super(key: key);

  String _calcBmi(double bmi) {
    String res;
    if (bmi >= 35) {
      res = '초고도비만';
    } else if (bmi >= 30) {
      res = '고도비만';
    } else if (bmi >= 25) {
      res = '경도비만';
    } else if (bmi >= 23) {
      res = '과체중';
    } else if (bmi >= 18.5) {
      res = '정상';
    } else {
      res = '저체중';
    }

    return res;
  }

  Widget _buildIcon(double bmi) {
    Icon icon = const Icon(
      Icons.sentiment_dissatisfied,
      color: Colors.green,
      size: 75,
    );
    if (bmi >= 23) {
      icon = const Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 75,
      );
    } else if (bmi >= 18.5) {
      icon = const Icon(
        Icons.sentiment_satisfied,
        color: Colors.greenAccent,
        size: 75,
      );
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final bmi = weight / ((height / 100) * (height / 100));

    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _calcBmi(bmi),
              style: const TextStyle(fontSize: 25),
            ),
            _buildIcon(bmi),
          ],
        ),
      ),
    );
  }
}
