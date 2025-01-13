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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _filteredMeals.clear();
      _errorMessage = '';
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search for food...',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          _searchMeals(_searchController.text);
                        },
                      ),
                    ),
                    onSubmitted: _searchMeals,
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearSearch,
                ),
              ],
            ),
            SizedBox(height: 20),

            if (_isLoading)
              Center(child: CircularProgressIndicator()),

            if (_errorMessage.isNotEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            if (!_isLoading && _filteredMeals.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredMeals.length - 1, 
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_filteredMeals[index]),
                      ),
                    );
                  },
                ),
              ),
            if (_filteredMeals.isEmpty && !_isLoading)
              Expanded(
                child: Center(
                  child: Text(
                    "No results available. Try refining your search.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
