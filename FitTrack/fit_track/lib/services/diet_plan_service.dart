import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/diet_plan_model.dart';

class DietPlanService {

  final String uid;

  DietPlanService({required this.uid});

  final CollectionReference<Map<String, dynamic>> dietPlansCollection = FirebaseFirestore.instance.collection('dietPlans');

  Future getDietPlan() async {
    final QuerySnapshot<Map<String, dynamic>> data = await dietPlansCollection.where('userId', isEqualTo: uid).get();
    
  }
}