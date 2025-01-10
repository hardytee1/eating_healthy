import 'package:flutter/material.dart';
import '../utils/meal_data.dart';

class DashboardPage extends StatelessWidget {
  final int age;
  final String gender;
  final String dietPreference;
  final String allowedFood;

  DashboardPage({
    required this.age,
    required this.gender,
    required this.dietPreference,
    required this.allowedFood,
  });

  @override
  Widget build(BuildContext context) {
    final meals = MealData.getMeals();

    return Scaffold(
      appBar: AppBar(title: Text('Your Meal Plan')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Details
            Text(
              'Hello! Here is your personalized plan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Age: $age'),
            Text('Gender: $gender'),
            Text('Diet Preference: $dietPreference'),
            Text('Allowed Food: $allowedFood'),
            SizedBox(height: 20),

            // Meal Plan
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
