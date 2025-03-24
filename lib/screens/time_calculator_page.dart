import 'package:flutter/material.dart';
import 'package:time_cal/theme/colors.dart';
import '../services/time_calculator_service.dart';

class TimeCalculatorPage extends StatefulWidget {
  const TimeCalculatorPage({super.key});

  @override
  _TimeCalculatorPageState createState() => _TimeCalculatorPageState();
}

class _TimeCalculatorPageState extends State<TimeCalculatorPage> {
  final List<TextEditingController> _timeControllers = [
    TextEditingController()
  ];
  String _result = "";

  void _onTimeChanged(String value, TextEditingController controller) {
    if (value.length == 2 && !value.contains(':')) {
      controller.text = "$value:";
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  }

  void _addTimeField() {
    setState(() {
      _timeControllers.add(TextEditingController());
    });
  }

  void _removeTimeField(int index) {
    setState(() {
      _timeControllers.removeAt(index);
    });
  }

  void _clearAllTimes() {
    setState(() {
      _timeControllers.clear();
      _result = "";
      _timeControllers.add(TextEditingController());
    });
  }

  void _calculate(bool isAddition) {
    setState(() {
      _result = isAddition
          ? TimeCalculatorLogic.addAllTimes(_timeControllers)
          : TimeCalculatorLogic.subtractAllTimes(_timeControllers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Time Calculator',
          style: TextStyle(color: white, fontWeight: FontWeight.w400),
        ),
        backgroundColor: black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ..._timeControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: entry.value,
                            decoration: const InputDecoration(
                                // labelText: 'Enter time (HH:MM)',
                                hintText: 'Enter time (HH:MM)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)))),
                            keyboardType: TextInputType.datetime,
                            onChanged: (value) =>
                                _onTimeChanged(value, entry.value),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle, color: red),
                          onPressed: () => _removeTimeField(index),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _calculate(false),
                      child: const Text(
                        'Subtract All',
                        style: TextStyle(color: black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _calculate(true),
                      child: const Text(
                        'Add All',
                        style: TextStyle(
                          color: black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _clearAllTimes,
                      style: ElevatedButton.styleFrom(backgroundColor: red),
                      child: const Text(
                        'Clear All',
                        style: TextStyle(color: black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _addTimeField,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: greenAccent),
                      child: const Text(
                        'Add Another Time Field',
                        style: TextStyle(color: black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  _result,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
