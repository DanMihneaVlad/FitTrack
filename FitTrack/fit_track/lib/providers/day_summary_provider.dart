import 'package:flutter/cupertino.dart';

import '../models/day_summary_model.dart';
import '../services/day_summary_service.dart';

class DaySummaryProvider extends ChangeNotifier {
  late DaySummaryService _daySummaryService;
  late DaySummaryModel daySummary;
  late Future getDaySummary;
  final String uid;

  DaySummaryProvider({required this.uid}) {
    _daySummaryService = DaySummaryService(uid: uid);
    getDaySummary = _getDaySummaryFuture();
  }

  Future _getDaySummaryFuture() async {
    final daySummary = await _daySummaryService.getDaySummary();
  }
}