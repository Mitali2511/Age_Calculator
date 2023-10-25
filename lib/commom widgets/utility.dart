import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utility {
  static Widget customizedText({
    String? text,
  }) {
    return Text("$text",
        style: const TextStyle(
            color: Color.fromARGB(255, 91, 72, 177),
            fontSize: 16,
            fontWeight: FontWeight.bold));
  }

  static Widget smallText({String? small_text}) {
    return Text("$small_text",
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
  }

  static Container separater({
    double? height,
  }) {
    return Container(
        height: height,
        width: 3.0,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 110, 110, 110),
        ));
  }

  static Container containerDecoration({double? height, Widget? widget}) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 70, 70, 70)),
            color: const Color.fromARGB(225, 221, 221, 221),
            borderRadius: BorderRadius.circular(10)),
        height: height,
        width: double.infinity,
        child: widget);
  }
}
