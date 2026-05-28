import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../models/onboarding_model.dart';

class ApiService {

  static Future<void> submitOnboarding(
      OnboardingModel model) async {

    final response = await http.post(
      Uri.parse(
        '${ApiConstants.baseUrl}/onboarding',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Onboarding failed",
      );
    }
  }

  static Future<Map<String, dynamic>>
      generateMealPlan(String userId) async {

    final response = await http.post(
      Uri.parse(
        '${ApiConstants.baseUrl}/generate-meal-plan/$userId',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        body['detail'] ?? body['error'] ?? 'Meal generation failed',
      );
    }

    return body;
  }

  static Future<List<dynamic>>
      fetchMealHistory(
    String userId,
  ) async {

    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/meal-history/$userId',
      ),
    );

    if (response.statusCode != 200) {

      throw Exception(
        "Failed to fetch meal history",
      );
    }

    return jsonDecode(response.body);
  }
}