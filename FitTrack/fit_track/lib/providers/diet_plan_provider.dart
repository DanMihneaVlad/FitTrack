import 'package:flutter/cupertino.dart';

import '../models/diet_plan_model.dart';
import '../services/diet_plan_service.dart';

class DietPlanProvider extends ChangeNotifier {
  late DietPlanService _dietPlanService;
  late DietPlanModel _dietPlan;
}