import 'package:flutter/material.dart';
import '../utils/meal_data.dart';

class FoodIWantPage extends StatefulWidget {
  @override
  _FoodIWantPageState createState() => _FoodIWantPageState();
}

class _FoodIWantPageState extends State<FoodIWantPage> {
  List<String> _filteredMeals = MealData.getMeals();
  final _searchController = TextEditingController();

  void _searchMeals(String query) {
    setState(() {
      _filteredMeals = MealData.getMeals().where((meal) {
        return meal.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Food You Want'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for food...',
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

            // Food List
            Expanded(
              child: ListView.builder(
                itemCount: _filteredMeals.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_filteredMeals[index]),
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
