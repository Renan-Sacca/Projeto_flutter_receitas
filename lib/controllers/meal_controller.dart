import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meal_app/models/meal.dart';

class MealController {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Meal>> fetchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List meals = data['meals'];
      return meals.map((meal) => Meal.fromJson(meal)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
