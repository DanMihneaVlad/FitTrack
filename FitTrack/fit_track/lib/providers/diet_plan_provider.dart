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
  late Future updateDietPlan;
  late Future getUser;
  final String uid;

  DietPlanProvider({required this.uid}) {
    _dietPlanService = DietPlanService(uid: uid);
    _userService = UserService(uid: uid);
    getDietPlan = _getDietPlanFuture();
    updateDietPlan = _updateDietPlanFuture();
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

  Future _updateDietPlanFuture() async {
    notifyListeners();
  }

  Future _getUserFuture() async {
    user = await _userService.getUserDetails();
  }

  DietPlanModel _createDefaultDietPlan() {
    return DietPlanModel(uid: '', userId: '', calorieTarget: 0, dietType: '', perWeekTarget: 0);
  }
}