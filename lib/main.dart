import 'package:flutter/material.dart';

void main() {
  runApp(TimeCalculatorApp());
}

class TimeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimeCalculatorPage(),
    );
  }
}

class TimeCalculatorPage extends StatefulWidget {
  @override
  _TimeCalculatorPageState createState() => _TimeCalculatorPageState();
}

class _TimeCalculatorPageState extends State<TimeCalculatorPage> {
  List<TextEditingController> _timeControllers = [TextEditingController()];
  String _result = "";

  Duration parseTime(String time) {
    final parts = time.split(':');
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    return Duration(hours: hours, minutes: minutes);
  }

  String formatTime(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return "$hours:$minutes";
  }

  void addAllTimes() {
    Duration total = Duration();
    for (var controller in _timeControllers) {
      total += parseTime(controller.text);
    }
    setState(() {
      _result = "Result: ${formatTime(total)}";
    });
  }

  void subtractAllTimes() {
    if (_timeControllers.isEmpty || _timeControllers[0].text.isEmpty) return;

    Duration total = parseTime(_timeControllers[0].text);
    for (int i = 1; i < _timeControllers.length; i++) {
      total -= parseTime(_timeControllers[i].text);
    }
    setState(() {
      _result = "Result: ${formatTime(total)}";
    });
  }

  void addTimeField() {
    setState(() {
      _timeControllers.add(TextEditingController());
    });
  }

  void removeTimeField(int index) {
    setState(() {
      _timeControllers.removeAt(index);
    });
  }

  void clearAllTimes() {
    setState(() {
      _timeControllers.clear();
      _result = "";
      _timeControllers.add(TextEditingController());
    });
  }

  void _onTimeChanged(String value, TextEditingController controller) {
    if (value.length == 2 && !value.contains(':')) {
      controller.text = "$value:";
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Calculator'),
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
                              labelText: 'Enter time (HH:MM)',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.datetime,
                            onChanged: (value) =>
                                _onTimeChanged(value, entry.value),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: () => removeTimeField(index),
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
                      onPressed: subtractAllTimes,
                      child: const Text('Subtract All'),
                    ),
                    ElevatedButton(
                      onPressed: addAllTimes,
                      child: const Text('Add All'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: clearAllTimes,
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Clear All'),
                    ),
                    ElevatedButton(
                      onPressed: addTimeField,
                      child: const Text('Add Another Time Field'),
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
