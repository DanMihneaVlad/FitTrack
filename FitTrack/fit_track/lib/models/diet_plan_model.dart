class DietPlanModel {
  final String uid;
  String userId;
  double calorieTarget;
  String dietType;
  double perWeekTarget;

  DietPlanModel({
    required this.uid,
    required this.userId,
    required this.calorieTarget,
    required this.dietType,
    required this.perWeekTarget
  });
}