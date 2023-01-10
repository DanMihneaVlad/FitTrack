import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/diet_plan_model.dart';

class DietPlanService {

  final String uid;

  DietPlanService({required this.uid});

  final CollectionReference<Map<String, dynamic>> dietPlansCollection = FirebaseFirestore.instance.collection('dietPlans');

  Future getDietPlan() async {
    try {

      final QuerySnapshot<Map<String, dynamic>> response = await dietPlansCollection.where('userId', isEqualTo: uid).get();
      
      if (response.docs.isNotEmpty) {
        
        final dietPlan = DietPlanModel.fromFirestore(response.docs[0]);
        
        return dietPlan;
      } else {
        return null;
      }

    } on Exception catch (e) {
      return e;
    }
  }
}