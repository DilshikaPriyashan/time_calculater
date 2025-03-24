import 'package:flutter/material.dart';

class TimeCalculatorLogic {
  static Duration parseTime(String time) {
    final parts = time.split(':');
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    return Duration(hours: hours, minutes: minutes);
  }

  static String formatTime(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return "$hours:$minutes";
  }

  static String addAllTimes(List<TextEditingController> controllers) {
    Duration total = Duration();
    for (var controller in controllers) {
      total += parseTime(controller.text);
    }
    return "Result: ${formatTime(total)}";
  }

  static String subtractAllTimes(List<TextEditingController> controllers) {
    if (controllers.isEmpty || controllers[0].text.isEmpty) return "";

    Duration total = parseTime(controllers[0].text);
    for (int i = 1; i < controllers.length; i++) {
      total -= parseTime(controllers[i].text);
    }
    return "Result: ${formatTime(total)}";
  }
}
