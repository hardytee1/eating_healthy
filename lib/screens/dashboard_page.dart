import 'package:flutter/material.dart';
import '../utils/meal_data.dart';

class DashboardPage extends StatelessWidget {
  final int age;
  final String gender;
  final String dietPreference;

  DashboardPage({
    required this.age,
    required this.gender,
    required this.dietPreference,
  });

  @override
  Widget build(BuildContext context) {
    final meals = MealData.getMeals();

    return Scaffold(
      appBar: AppBar(title: Text('Your Meal Plan')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Day ${index + 1}'),
                subtitle: Text(meals[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
