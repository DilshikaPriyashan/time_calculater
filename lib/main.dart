import 'package:flutter/material.dart';
import 'screens/time_calculator_page.dart';

void main() {
  runApp(const TimeCalculatorApp());
}

class TimeCalculatorApp extends StatelessWidget {
  const TimeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TimeCalculatorPage(),
    );
  }
}
