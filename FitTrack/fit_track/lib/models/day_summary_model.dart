import 'package:cloud_firestore/cloud_firestore.dart';

class DaySummaryModel {
  String uid;
  String userId;
  String date;
  double caloriesConsumed;
  double carbs;
  double sugars;
  double fats;
  double proteins;

  DaySummaryModel({
    required this.uid,
    required this.userId,
    required this.date,
    required this.caloriesConsumed,
    required this.carbs,
    required this.sugars,
    required this.fats,
    required this.proteins
  });

  factory DaySummaryModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return DaySummaryModel(
      uid: snapshot.id, 
      userId: data?['userId'], 
      date: data?['date'],
      caloriesConsumed: data?['caloriesConsumed'], 
      carbs: data?['carbs'], 
      sugars: data?['sugars'],
      fats: data?['fats'],
      proteins: data?['proteins']
    );
  }
}