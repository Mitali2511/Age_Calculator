import 'dart:async';

import 'package:agecalculator/view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 91, 72, 177),
      body:  Container(
        decoration: BoxDecoration(),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/agecalculatorLogo.png',
          fit: BoxFit.fitHeight,
         
        ),
      
      )

    );
  }
}