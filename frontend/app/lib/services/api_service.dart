import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "http://localhost:8000";

  static Future<void> submitOnboarding(
      Map<String, dynamic> data) async {

    final response = await http.post(
      Uri.parse('$baseUrl/onboarding'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed onboarding");
    }
  }

  static Future<Map<String, dynamic>> generateMealPlan(
      String userId) async {

    final response = await http.post(
      Uri.parse('$baseUrl/generate-meal-plan/$userId'),
    );

    if (response.statusCode != 200) {
      throw Exception("Meal generation failed");
    }

    return jsonDecode(response.body);
  }
}