import 'package:flutter/material.dart';

class MealPlanScreen extends StatelessWidget {

  final Map<String, dynamic> mealData;

  const MealPlanScreen({
    super.key,
    required this.mealData,
  });

  @override
  Widget build(BuildContext context) {

    final meals = mealData["meal_plan"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Plan"),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {

          final day = meals.keys.elementAt(index);
          final dayMeals = meals[day];

          return Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    day.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Breakfast: ${dayMeals['breakfast']}",
                  ),

                  Text(
                    "Lunch: ${dayMeals['lunch']}",
                  ),

                  Text(
                    "Dinner: ${dayMeals['dinner']}",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}