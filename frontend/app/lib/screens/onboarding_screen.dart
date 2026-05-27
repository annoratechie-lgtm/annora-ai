import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'meal_plan_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {

  final ageController = TextEditingController();
  final budgetController = TextEditingController();

  bool loading = false;

  Future<void> submit() async {

    setState(() {
      loading = true;
    });

    final data = {
      "user_id": "user_1",
      "age": int.parse(ageController.text),
      "gender": "male",
      "diet_type": "vegetarian",
      "allergies": [],
      "budget": int.parse(budgetController.text),
      "family_size": 2
    };

    await ApiService.submitOnboarding(data);

    final mealData =
        await ApiService.generateMealPlan("user_1");

    setState(() {
      loading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealPlanScreen(
          mealData: mealData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: "Age",
              ),
            ),

            TextField(
              controller: budgetController,
              decoration: const InputDecoration(
                labelText: "Budget",
              ),
            ),

            const SizedBox(height: 20),

            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: submit,
                    child: const Text(
                      "Generate Meal Plan",
                    ),
                  )
          ],
        ),
      ),
    );
  }
}