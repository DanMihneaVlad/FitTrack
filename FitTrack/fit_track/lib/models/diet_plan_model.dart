import 'package:cloud_firestore/cloud_firestore.dart';

class DietPlanModel {
  String uid;
  String userId;
  double calorieTarget;
  String dietType;
  String perWeekTarget;

  DietPlanModel({
    required this.uid,
    required this.userId,
    required this.calorieTarget,
    required this.dietType,
    required this.perWeekTarget
  });

  factory DietPlanModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return DietPlanModel(
      uid: snapshot.id, 
      userId: data?['userId'], 
      calorieTarget: data?['calorieTarget'], 
      dietType: data?['dietType'], 
      perWeekTarget: data?['perWeekTarget']
    );
  }
}