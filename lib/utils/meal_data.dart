import 'dart:math';

class MealData {
  static List<String> getMeals() {
    return [
      'Grilled Chicken Salad with Quinoa',
      'Vegetable Stir-Fry with Tofu',
      'Lentil Soup with Whole Wheat Bread',
      'Grilled Salmon with Steamed Broccoli',
      'Vegetarian Pasta Primavera',
      'Chicken and Avocado Wrap',
      'Mediterranean Buddha Bowl',
      'Indonesian Gado-Gado',
      'Nasi Goreng (Healthy)',
      'Sate Ayam (Grilled Chicken Skewers)',
    ];
  }

  static List<String> getRandomMeals() {
    List<String> meals = getMeals();
    meals.shuffle(Random());
    return meals.sublist(0, 7); // Return exactly 7 meals
  }

  static String getRandomMeal() {
    List<String> meals = getMeals();
    return meals[Random().nextInt(meals.length)]; // Get a single random meal
  }
}
