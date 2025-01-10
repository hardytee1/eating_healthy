import 'package:flutter/material.dart';
import '../utils/meal_data.dart';
import 'food_i_want_page.dart';

class DashboardPage extends StatefulWidget {
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
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> _meals = MealData.getRandomMeals();

  void _refreshMeal(int dayIndex) {
    setState(() {
      _meals[dayIndex] = MealData.getRandomMeal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthy Eating Planner'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Details
            Text(
              'Welcome to your Healthy Eating Plan!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Age: ${widget.age}'),
            Text('Gender: ${widget.gender}'),
            Text('Diet Preference: ${widget.dietPreference}'),
            Text('Allowed Food: ${widget.allowedFood}'),
            SizedBox(height: 20),

            // Meal Plan List
            Expanded(
              child: ListView.builder(
                itemCount: 7, // Show exactly 7 days
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Day ${index + 1}'),
                      subtitle: Text(_meals[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => _refreshMeal(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Plan Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // No action needed since the user is already on this page
                },
                child: Text('Plan'),
              ),
            ),
            // Food I Want Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodIWantPage(),
                    ),
                  );
                },
                child: Text('Food I Want'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
