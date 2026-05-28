import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/onboarding_model.dart';
import '../services/api_service.dart';

final loadingProvider =
    StateProvider<bool>((ref) => false);

final mealProvider =
    StateProvider<Map<String, dynamic>?>(
  (ref) => null,
);

class MealService {

  static Future<void> generateMeal(
    OnboardingModel model,
    WidgetRef ref,
  ) async {

    ref.read(loadingProvider.notifier).state =
        true;

    try {
      await ApiService.submitOnboarding(model);

      final result =
          await ApiService.generateMealPlan(
        model.userId,
      );

      ref.read(mealProvider.notifier).state =
          result;
    } finally {
      ref.read(loadingProvider.notifier).state =
          false;
    }
  }
}