import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/providers/diet_plan_provider.dart';
import 'package:fit_track/providers/meals_provider.dart';
import 'package:fit_track/providers/recipe_provider.dart';
import 'package:fit_track/providers/user_details_provider.dart';
import 'package:fit_track/screens/recipes/add_recipe.dart';
import 'package:fit_track/widgets/custom_create_diet_plan_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_day_summary.dart';
import 'create_diet_plan.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dietPlanProvider = context.watch<DietPlanProvider>();
    var mealsProvider = context.watch<MealsProvider>();
    var widgets = CustomCreateDietPlanWidgets().createWidgets(
        'It appears you don\'t have a diet plan yet. Try creating one now by pressing the button below.');

    return FutureBuilder(
        future: Future.wait([
          dietPlanProvider.getDietPlan,
          mealsProvider.getTodayDaySummary,
        ]),
        builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            if (asyncSnapshot.hasError) {
              return const Center(child: Text('Could not load the user data!'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 194, 194, 194),
                            spreadRadius: 1.5,
                            blurRadius: 5,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.waving_hand_rounded,
                              color: Colors.green,
                              size: 50.0,
                            ),
                            const SizedBox(width: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Welcome ' +
                                      dietPlanProvider.user.firstName +
                                      '!\n' 'How are you today?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 460,
                    width: 400,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 194, 194, 194),
                            spreadRadius: 1.5,
                            blurRadius: 5,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: dietPlanProvider.dietPlan.uid.isEmpty
                              ? [
                                  widgets[0],
                                  widgets[1],
                                  widgets[2],
                                  const SizedBox(height: 40),
                                  GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ChangeNotifierProvider.value(
                                                    value: context.read<
                                                        DietPlanProvider>(),
                                                    child: CreateDietPlan(),
                                                  )))
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Create diet plan',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ]
                              : [
                                CustomDaySummary(title: 'Today\'s summary', dietPlan: dietPlanProvider.dietPlan, daySummary: mealsProvider.todayDaySummary),
                                const SizedBox(height: 30),
                                  GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ChangeNotifierProvider.value(
                                                    value: context.read<
                                                        DietPlanProvider>(),
                                                    child: CreateDietPlan(),
                                                  )))
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Update diet plan',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ]),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
