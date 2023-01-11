import 'package:flutter/cupertino.dart';

import '../models/day_summary_model.dart';
import '../services/day_summary_service.dart';

class DaySummaryProvider extends ChangeNotifier {
  late DaySummaryService _daySummaryService;
  late DaySummaryModel todayDaySummary;
  late DaySummaryModel choosenDateDaySummary;
  late Future getTodayDaySummary;
  final String uid;

  DaySummaryProvider({required this.uid}) {
    _daySummaryService = DaySummaryService(uid: uid);
    getTodayDaySummary = _getTodayDaySummaryFuture();
  }

  Future _getTodayDaySummaryFuture() async {
    final daySummary = await _daySummaryService.getTodayDaySummary();
  }

  Future _getDateDaySummary(DateTime date) async {
    final choosenDateDaySummary = await _daySummaryService.getTodayDaySummary();
  }
}