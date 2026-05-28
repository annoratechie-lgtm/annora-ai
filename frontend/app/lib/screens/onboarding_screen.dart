import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/onboarding_model.dart';
import '../providers/meal_provider.dart';
import '../services/auth_service.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/primary_button.dart';
import 'meal_plan_screen.dart';
import 'login_screen.dart';
import 'history_screen.dart';

class OnboardingScreen
    extends ConsumerStatefulWidget {

  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen>
      createState() =>
          _OnboardingScreenState();
}

class _OnboardingScreenState
    extends ConsumerState<OnboardingScreen> {

  final ageController =
      TextEditingController();

  final budgetController =
      TextEditingController();

  Future<void> submit() async {

    try {

      if (ageController.text.isEmpty ||
          budgetController.text.isEmpty) {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Please fill all fields",
            ),
          ),
        );

        return;
      }

      final currentUser =
          AuthService.currentUser();

      if (currentUser == null) {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "User not logged in",
            ),
          ),
        );

        return;
      }

      final model = OnboardingModel(
        userId: currentUser.id,
        age: int.parse(
          ageController.text,
        ),
        gender: "male",
        dietType: "vegetarian",
        allergies: [],
        budget: int.parse(
          budgetController.text,
        ),
        familySize: 2,
      );

      await MealService.generateMeal(
        model,
        ref,
      );

      final mealData =
          ref.read(mealProvider);

      if (mealData != null) {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                MealPlanScreen(
              mealData: mealData,
            ),
          ),
        );
      }

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final loading =
        ref.watch(loadingProvider);

    return Scaffold(
      appBar: AppBar(
      title: const Text(
        "AI Meal Planner",
      ),
      actions: [
        IconButton(
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const HistoryScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.history,
          ),
        ),
        IconButton(
          onPressed: () async {

            await AuthService.logout();

            if (!mounted) return;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const LoginScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.logout,
          ),
        ),
      ],
    ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [

            CustomTextField(
              controller:
                  ageController,
              label: "Age",
              isNumber: true,
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller:
                  budgetController,
              label: "Budget",
              isNumber: true,
            ),

            const SizedBox(height: 30),

            PrimaryButton(
              text:
                  "Generate Meal Plan",
              onPressed: submit,
              loading: loading,
            ),
          ],
        ),
      ),
    );
  }
}