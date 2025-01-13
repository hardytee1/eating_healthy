import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://4.240.96.2:8000"; 

  static Future<List<String>> generateMealPlan({
    required int age,
    required String gender,
    required String dietPreference,
    required String allowedFood,
  }) async {
    final uri = Uri.parse("$baseUrl/generate-meal-plan/").replace(queryParameters: {
      'age': age.toString(),
      'gender': gender,
      'diet_preference': dietPreference,
      'allowed_food': allowedFood,
    });

    try {
      final response = await http.get(uri, headers: {"Content-Type": "application/json"});

      print("Request URL: $uri");
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['meal_plan'] != null) {
          return data['meal_plan'].split("\n");
        } else {
          throw Exception("Meal plan data not found.");
        }
      } else {
        throw Exception("Failed to generate meal plan: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to generate meal plan. Please try again.");
    }
  }

  static Future<List<String>> searchFood(String query) async {
    final uri = Uri.parse("$baseUrl/search-food/").replace(queryParameters: {
      'query': query,
    });

    try {
      final response = await http.get(uri, headers: {"Content-Type": "application/json"});

      print("Request URL: $uri");
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['recipes'] != null) {
          return data['recipes'].split("\n");
        } else {
          throw Exception("No recipes found.");
        }
      } else {
        throw Exception("Failed to fetch recipes: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to fetch recipes. Please try again.");
    }
  }

}
