import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_track/models/day_summary_model.dart';

class DaySummaryService {

  final String uid;

  DaySummaryService({required this.uid});

  final CollectionReference<Map<String, dynamic>> daySummaryCollection = FirebaseFirestore.instance.collection('daySummaries');

  Future getDaySummary() async {
    try {

      final QuerySnapshot<Map<String, dynamic>> response = await daySummaryCollection.where('userId', isEqualTo: uid).get();
      
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
}