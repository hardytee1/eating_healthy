import 'package:flutter/material.dart';
import '../services/api_service.dart';
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
  List<String> _meals = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchMealPlan();
  }

  void _fetchMealPlan() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final results = await ApiService.generateMealPlan(
        age: widget.age,
        gender: widget.gender,
        dietPreference: widget.dietPreference,
        allowedFood: widget.allowedFood,
      );

      setState(() {
        _meals = results;
        if (_meals.isEmpty) {
          _errorMessage = "No meals available. Please try again.";
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to fetch meal plan. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _refreshMealPlan() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    _fetchMealPlan(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthy Eating Planner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to your Healthy Eating Plan!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Age: ${widget.age}'),
            Text('Gender: ${widget.gender}'),
            Text('Diet Preference: ${widget.dietPreference}'),
            Text('Allowed Food: ${widget.allowedFood}'),
            Divider(height: 30, thickness: 1),

            Center(
              child: ElevatedButton.icon(
                onPressed: _refreshMealPlan,
                icon: Icon(Icons.refresh),
                label: Text("Refresh Meal Plan"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 20),

            if (_isLoading)
              Center(child: CircularProgressIndicator()),

            if (_errorMessage.isNotEmpty)
              Center(
                child: Column(
                  children: [
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _fetchMealPlan,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),

            if (!_isLoading && _meals.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _meals.length -1,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        // title: Text('Day ${index + 1}'),
                        title: Text(_meals[index]),
                      ),
                    );
                  },
                ),
              ),

            if (_meals.isEmpty && !_isLoading)
              Center(child: Text("No meals available. Please try again.")),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.calendar_today),
              label: Text('Plan'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodIWantPage(),
                  ),
                );
              },
              icon: Icon(Icons.fastfood),
              label: Text('Food I Want'),
            ),
          ],
        ),
      ),
    );
  }
}