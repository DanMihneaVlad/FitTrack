import 'package:fit_track/models/diet_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomDietPlanCard extends StatefulWidget {
  const CustomDietPlanCard({super.key, required this.dietPlan});

  final DietPlanModel dietPlan;

  @override
  State<CustomDietPlanCard> createState() => _CustomDietPlanCardState();
}

class _CustomDietPlanCardState extends State<CustomDietPlanCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          child: Text(
            'Diet plan information',
            style: TextStyle(
              fontSize: 22,
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
                Text(
                  'Diet type: ' + widget.dietPlan.dietType,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Calorie target: ' +
                      widget.dietPlan.calorieTarget.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                widget.dietPlan.dietType != 'Maintain weight'
                    ? _getTargetWidget()
                    : Container(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _getTargetWidget() {
    return Text(
      'Target per week: ' + widget.dietPlan.perWeekTarget,
      style: TextStyle(
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }
}
