import 'package:fit_track/models/day_summary_model.dart';
import 'package:fit_track/models/diet_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class CustomDaySummary extends StatefulWidget {
  const CustomDaySummary(
      {super.key,
      required this.title,
      required this.dietPlan,
      required this.daySummary});

  final String title;
  final DietPlanModel dietPlan;
  final DaySummaryModel daySummary;

  @override
  State<CustomDaySummary> createState() => _CustomDaySummaryState();
}

class _CustomDaySummaryState extends State<CustomDaySummary> {
  late ValueNotifier<double> valueNotifier;

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(widget.daySummary.caloriesConsumed);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),

        SimpleCircularProgressBar(
          size: 150,
          mergeMode: true,
          valueNotifier: valueNotifier,
          onGetText: (value) {
            return Text(
              widget.daySummary.caloriesConsumed.toStringAsFixed(2) + '/\n' + widget.dietPlan.calorieTarget.toStringAsFixed(2) + '\ncalories consumed',
              textAlign: TextAlign.center,
            );
          },
          progressColors: _getColors(widget.dietPlan.dietType),
          maxValue: widget.dietPlan.calorieTarget,
        ),

        const SizedBox(height: 20),
        Container(
          child: Text(
            _getProgressText(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
                children: [
                  Text('Diet type: ' + widget.dietPlan.dietType),
                ],
              ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
                children: [
                  const Text('Carbs'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.daySummary.carbs.toStringAsFixed(2)),
                ],
              ),
              Column(
                children: [
                  const Text('Sugars'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.daySummary.sugars.toStringAsFixed(2)),
                ],
              ),
              Column(
                children: [
                  const Text('Fat'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.daySummary.fats.toStringAsFixed(2)),
                ],
              ),
              Column(
                children: [
                  const Text('Protein'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.daySummary.proteins.toStringAsFixed(2)),
                ],
              )
          ],
        ),
      ],
      
    );
  }

  List<Color> _getColors(String dietType) {
    if (dietType == 'Lose weight') {
      return [Colors.blue, Colors.red];
    } else if (dietType == 'Gain weight') {
      return [Colors.red, Colors.blue];
    } else if (dietType == 'Maintain weight') {
      return [Colors.blue];
    } else {
      return [Colors.blue];
    }
  }

  String _getProgressText() {
    if (widget.dietPlan.dietType == 'Lose weight') {
      if (widget.daySummary.caloriesConsumed >= widget.dietPlan.calorieTarget) {
        return 'You consumed more calories than you should have for your target';
      } else {
        return 'You are on course for the target';
      }
    } else if (widget.dietPlan.dietType == 'Gain weight') {
      if (widget.daySummary.caloriesConsumed >= widget.dietPlan.calorieTarget - 100) {
        return 'You are on course for the target';
      } else {
        return 'You need to consume more calories to reach your target';
      }
    } else if (widget.dietPlan.dietType == 'Maintain weight') {
      if (widget.daySummary.caloriesConsumed >= widget.dietPlan.calorieTarget - 150) {
        if (widget.daySummary.caloriesConsumed <= widget.dietPlan.calorieTarget + 150) {
          return 'You are on course for the target';
        } else {
          return 'You consumed more calories than you should have for your target';
        }
      } else {
        return 'You need to consume more calories to reach your target';
      }
    } else {
      return '';
    }
  }
}
