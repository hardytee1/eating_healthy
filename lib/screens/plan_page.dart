import 'package:flutter/material.dart';
import '../utils/meal_data.dart';

class PlanPage extends StatefulWidget {
  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  List<String> _meals = MealData.getMeals();
  final _searchController = TextEditingController();

  void _refreshMeals() {
    setState(() {
      _meals = MealData.getRandomMeals();
    });
  }

  void _searchMeals(String query) {
    setState(() {
      _meals = MealData.getMeals().where((meal) {
        return meal.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Your Meals'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for meals...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchMeals(_searchController.text);
                  },
                ),
              ),
              onSubmitted: _searchMeals,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _refreshMeals,
              child: Text('Refresh Meals'),
            ),
            SizedBox(height: 10),

            // Meal List
            Expanded(
              child: ListView.builder(
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Day ${index + 1}'),
                      subtitle: Text(_meals[index]),
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
