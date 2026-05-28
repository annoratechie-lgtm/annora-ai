class MealPlanModel {

  final Map<String, dynamic> meals;

  MealPlanModel({
    required this.meals,
  });

  factory MealPlanModel.fromJson(
      Map<String, dynamic> json) {

    return MealPlanModel(
      meals: json["meal_plan"],
    );
  }
}