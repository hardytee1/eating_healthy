import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';

void main() {
  runApp(HealthyEatingPlannerApp());
}

class HealthyEatingPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Eating Planner',
      theme: ThemeData(primarySwatch: Colors.green),
      home: WelcomePage(),
    );
  }
}

