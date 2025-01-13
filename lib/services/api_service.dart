import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000"; // Change to your backend URL

  static Future<List<String>> generateMealPlan({
    required int age,
    required String gender,
    required String dietPreference,
    required String allowedFood,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/generate-meal-plan/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "age": age,
        "gender": gender,
        "diet_preference": dietPreference,
        "allowed_food": allowedFood,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['meal_plan'].split("\n"); // Split into list if meal plan is line-separated
    } else {
      throw Exception("Failed to generate meal plan");
    }
  }

  static Future<List<String>> searchFood(String query) async {
    final response = await http.post(
      Uri.parse("$baseUrl/search-food/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"query": query}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['recipes'].split("\n"); // Split into list if recipes are line-separated
    } else {
      throw Exception("Failed to search food");
    }
  }
}
