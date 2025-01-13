import 'package:flutter/material.dart';
import '../services/api_service.dart';

class FoodIWantPage extends StatefulWidget {
  @override
  _FoodIWantPageState createState() => _FoodIWantPageState();
}

class _FoodIWantPageState extends State<FoodIWantPage> {
  List<String> _filteredMeals = [];
  final _searchController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  void _searchMeals(String query) async {
    if (query.isEmpty) {
      setState(() {
        _errorMessage = "Please enter a search query.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final results = await ApiService.searchFood(query);
      setState(() {
        _filteredMeals = results;
        if (_filteredMeals.isEmpty) {
          _errorMessage = "No recipes found for your query.";
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to fetch recipes. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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

            // Show loading indicator if searching
            if (_isLoading)
              Center(child: CircularProgressIndicator()),

            // Show error message if there's an error
            if (_errorMessage.isNotEmpty)
              Center(
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),

            // Food List (Only show if there are items in the list)
            if (!_isLoading && _filteredMeals.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredMeals.length - 1, //karena data yang dikeluarkan AI ada 6 /n
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_filteredMeals[index]),
                      ),
                    );
                  },
                ),
              ),
            // Hide ListView when no data
            if (_filteredMeals.isEmpty && !_isLoading)
              Center(child: Text("No results available.")),
          ],
        ),
      ),
    );
  }
}
