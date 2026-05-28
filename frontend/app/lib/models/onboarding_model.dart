class OnboardingModel {

  final String userId;
  final int age;
  final String gender;
  final String dietType;
  final List<String> allergies;
  final int budget;
  final int familySize;

  OnboardingModel({
    required this.userId,
    required this.age,
    required this.gender,
    required this.dietType,
    required this.allergies,
    required this.budget,
    required this.familySize,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "age": age,
      "gender": gender,
      "diet_type": dietType,
      "allergies": allergies,
      "budget": budget,
      "family_size": familySize,
    };
  }
}