import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateDietPlan extends StatefulWidget {
  const CreateDietPlan({super.key});

  @override
  State<CreateDietPlan> createState() => _CreateDietPlanState();
}

class _CreateDietPlanState extends State<CreateDietPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Create diet plan', backButton: true),
    );
  }
}