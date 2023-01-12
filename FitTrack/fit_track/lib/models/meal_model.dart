import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/food_model.dart';

class MealModel {
  String uid;
  String daySummaryId;
  String mealType;

  MealModel({
    required this.uid,
    required this.daySummaryId,
    required this.mealType,
  });

  factory MealModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return MealModel(
      uid: snapshot.id,
      daySummaryId: data?['daySummaryId'],
      mealType: data?['mealType']
    );
  }
}