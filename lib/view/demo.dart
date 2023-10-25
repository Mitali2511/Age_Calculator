import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  DateTime? _birthDate;
  DateTime? _currentDate;
  int? _years;
  int? _months;
  int? _days;

  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (picked != null && picked != (isBirthDate ? _birthDate : _currentDate)) {
      setState(() {
        if (isBirthDate) {
          _birthDate = picked;
        } else {
          _currentDate = picked;
        }
        _calculateAge();
      });
    }
  }

  void _calculateAge() {
    if (_birthDate != null && _currentDate != null) {
      final age = _currentDate!.difference(_birthDate!);
      final years = age.inDays ~/ 365;
      final months = (age.inDays % 365) ~/ 30;
      final days = (age.inDays % 365) % 30;
      setState(() {
        _years = years;
        _months = months;
        _days = days;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDate(context, true),
              child: Text('Select Birthdate'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _selectDate(context, false),
              child: Text('Select Current Date'),
            ),
            SizedBox(height: 20.0),
            Text(
              _birthDate == null || _currentDate == null
                  ? 'Select your birthdate and current date'
                  : 'Your age is $_years years, $_months months, and $_days days',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
