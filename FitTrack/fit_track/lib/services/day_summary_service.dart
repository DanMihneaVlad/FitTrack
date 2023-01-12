import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/day_summary_model.dart';
import 'package:intl/intl.dart';

class DaySummaryService {

  final String uid;

  DaySummaryService({required this.uid});

  final CollectionReference<Map<String, dynamic>> daySummaryCollection = FirebaseFirestore.instance.collection('daySummaries');

  Future getTodayDaySummary() async {
    try {

      DateTime now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);

      final QuerySnapshot<Map<String, dynamic>> response = await daySummaryCollection.where('userId', isEqualTo: uid).where('date', isEqualTo: formattedDate).get();
      
      if (response.docs.isNotEmpty) {
        
        final daySummary = DaySummaryModel.fromFirestore(response.docs[0]);
        
        return daySummary;
      } else {
        return null;
      }

    } on Exception catch (e) {
      return e;
    }
  }

  Future addDaySummary() async {

    try {

      double doublePlaceHolder = 0;

      DateTime now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(now);

      final docData = {
        'userId': uid,
        'date': formattedDate,
        'caloriesConsumed': doublePlaceHolder,
        'carbs': doublePlaceHolder,
        'sugars': doublePlaceHolder,
        'fats': doublePlaceHolder,
        'proteins': doublePlaceHolder
      };

      DocumentReference addedDaySummary = await daySummaryCollection.add(docData);
      DocumentSnapshot doc = await addedDaySummary.get();
      final data = doc.data() as Map<String, dynamic>;
      String date = data['date'];
      return <String>[doc.id, date];

    } on Exception catch (e) {
      return e;
    }
  }

  Future updateDaySummary(DaySummaryModel daySummary, double kcal, double carbs, double sugars, double fats, double proteins) async {
    
    try {

      double newCaloriesConsumed = daySummary.caloriesConsumed + kcal;
      double newCarbs = daySummary.carbs + carbs;
      double newSugars = daySummary.sugars + sugars;
      double newFats = daySummary.fats + fats;
      double newProteins = daySummary.proteins + proteins;

      final docData = {
        'caloriesConsumed': newCaloriesConsumed,
        'carbs': newCarbs,
        'sugars': newSugars,
        'fats': newFats,
        'proteins': newProteins
      };

      await daySummaryCollection.doc(daySummary.uid).update(docData);

    } on Exception catch (e) {
      return e;
    }
  }
}