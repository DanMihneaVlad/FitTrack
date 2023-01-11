import 'package:flutter/cupertino.dart';

import '../models/diet_plan_model.dart';
import '../models/user_model.dart';
import '../services/diet_plan_service.dart';
import '../services/user_service.dart';

class DietPlanProvider extends ChangeNotifier {
  late DietPlanService _dietPlanService;
  late UserService _userService;
  late DietPlanModel dietPlan;
  late UserModel user;
  late Future getDietPlan;
  late Future getUser;
  final String uid;

  DietPlanProvider({required this.uid}) {
    _dietPlanService = DietPlanService(uid: uid);
    _userService = UserService(uid: uid);
    getDietPlan = _getDietPlanFuture();
    getUser = _getUserFuture();
  }

  Future _getDietPlanFuture() async {
    await _getUserFuture();
    final _dietPlan = await _dietPlanService.getDietPlan();

    if (_dietPlan is DietPlanModel) {
      dietPlan = _dietPlan;
    } else {
      dietPlan = _createDefaultDietPlan();
    }
  }

  Future updateDietPlan(String age, String height, String weight, String sex, String activityLevel, String dietType, String target) async {
    try {
    
      await _userService.updateUserInformation(age, height, weight, sex, activityLevel);
      user.age = int.parse(age);
      user.weight = double.parse(weight);
      user.height = int.parse(height);
      user.sex = sex;
      user.activityLevel = activityLevel;

      double calorieTarget = computeCalorieTarget(age, height, weight, sex, activityLevel, dietType, target);

      if (dietPlan.uid == '') {
        String dietPlanUid = await _dietPlanService.addDietPlan(user.uid ,dietType, target, calorieTarget);
        dietPlan.uid = dietPlanUid;
        dietPlan.userId = user.uid;
        dietPlan.calorieTarget = calorieTarget;
        dietPlan.dietType = dietType;
        dietPlan.perWeekTarget = target;
      } else {
        await _dietPlanService.updateDietPlan(dietPlan.uid, dietType, target, calorieTarget);
        dietPlan.calorieTarget = calorieTarget;
        dietPlan.dietType = dietType;
        dietPlan.perWeekTarget = target;
      }
      
      notifyListeners();
      
    } on Exception catch (e) {
      return e;
    }
  }

  Future _getUserFuture() async {
    user = await _userService.getUserDetails();
  }

  DietPlanModel _createDefaultDietPlan() {
    return DietPlanModel(uid: '', userId: '', calorieTarget: 0, dietType: '', perWeekTarget: '');
  }

  double computeCalorieTarget(String age, String height, String weight, String sex, String activityLevel, String dietType, String target) {
    double exerciseModifier = getExerciseModifier(activityLevel);
    double targetModifier = getTargetModifier(target);
    double bmr = 0.0;

    if (sex == 'Male') {
      bmr = 66.47 + (13.75 * double.parse(weight)) + (5.003 * double.parse(height)) - (6.755 * double.parse(age));
    } else if (sex == 'Female') {
      bmr = 655.1 + (9.563 * double.parse(weight)) + (1.850 * double.parse(height)) - (4.676 * double.parse(age));
    }
    double amr = bmr * exerciseModifier;
    double finalCalorieTarget = amr;

    if (dietType == 'Lose weight') {
      finalCalorieTarget = amr - targetModifier;
    } else if (dietType == 'Gain weight') {
      finalCalorieTarget = amr + targetModifier;
    }

    return finalCalorieTarget;
  }

  double getTargetModifier(String target) {
    if (target == '0.25 kg') {
      return 250.0;
    } else if (target == '0.5 kg') {
      return 500.0;
    } else {
      return 0;
    }
  }

  double getExerciseModifier(String activityLevel) {
    if (activityLevel == 'Sedentary') {
      return 1.2;
    } else if (activityLevel == 'Light') {
      return 1.375;
    } else if (activityLevel == 'Moderate') {
      return 1.55;
    } else if (activityLevel == 'Active') {
      return 1.725;
    } else if (activityLevel == 'Very active') {
      return 1.9;
    } else {
      return 0;
    }
  }
}