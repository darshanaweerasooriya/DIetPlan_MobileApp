import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/clients/coachesSelection.dart';
import 'package:healthbiteapp/Screens/splash/splachScreen.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }
}


