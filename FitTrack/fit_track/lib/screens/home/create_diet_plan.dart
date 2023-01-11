import 'package:fit_track/providers/diet_plan_provider.dart';
import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:fit_track/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CreateDietPlan extends StatefulWidget {
  const CreateDietPlan({super.key});

  @override
  State<CreateDietPlan> createState() => _CreateDietPlanState();
}

class _CreateDietPlanState extends State<CreateDietPlan> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final List<String> _sexDropDown = ['Male', 'Female'];
  String _sexController = '';
  final List<String> _activityLevelDropDown = [
    'Sedentary',
    'Light',
    'Moderate',
    'Active',
    'Very active'
  ];
  String _activityLevelController = '';
  final List<String> _dietTypeDropDown = [
    'Lose weight',
    'Maintain weight',
    'Gain weight'
  ];
  String _dietTypeController = '';
  final List<String> _targetDropDown = ['0.25 kg', '0.5 kg'];
  String _targetController = '';

  String saveError = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.grey[250],
        filled: true);

    var user = context.read<DietPlanProvider>().user;

    _sexController = _sexDropDown[0];
    _activityLevelController = _activityLevelDropDown[0];
    _dietTypeController = _dietTypeDropDown[1];
    _targetController = _targetDropDown[0];

    if (user.age != 0) {
      _ageController.text = user.age.toString();
    }

    if (user.height != 0) {
      _heightController.text = user.height.toString();
    }

    if (user.weight != 0) {
      _weightController.text = user.weight.toString();
    }

    if (user.sex.isNotEmpty) {
      if (user.sex == 'Male') {
        _sexController = _sexDropDown[0];
      } else {
        _sexController = _sexDropDown[1];
      }
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'Create diet plan', backButton: true),
      body: SafeArea(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 30),

            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Please provide your information',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  // Age textfield
                  TextFormField(
                    controller: _ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      } else if (int.parse(value) < 12 ||
                          int.parse(value) > 100) {
                        return 'Please enter a valid age';
                      }
                      return null;
                    },
                    decoration: inputDecoration.copyWith(hintText: 'Age'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Height textfield
                  TextFormField(
                    controller: _heightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height in centimeters';
                      } else if (int.parse(value) < 60) {
                        return 'The height value can\'t be smaller than 60 cm';
                      } else if (int.parse(value) > 250) {
                        return 'The height value can\'t be bigger than 250 cm';
                      }
                      return null;
                    },
                    decoration:
                        inputDecoration.copyWith(hintText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Weight textfield
                  TextFormField(
                    controller: _weightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight in kilograms';
                      } else if (double.parse(value) > 400) {
                        return 'The weight can\'t be bigger than 400 kg';
                      } else if (double.parse(value) < 20) {
                        return 'The weight can\'t be smaller than 20 kg';
                      }
                      return null;
                    },
                    decoration:
                        inputDecoration.copyWith(hintText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Sex textfield
                  DropdownButtonFormField(
                    value: _sexController,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your sex';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      _sexController = newValue!;
                    },
                    items: _sexDropDown
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    decoration: inputDecoration.copyWith(hintText: 'Sex'),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'Please select your activity level',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  // Activity level textfield
                  DropdownButtonFormField(
                    value: _activityLevelController,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your activity level';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      _activityLevelController = newValue!;
                    },
                    items: _activityLevelDropDown
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    decoration:
                        inputDecoration.copyWith(hintText: 'Activity level'),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'Please enter your diet plan details',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  // Diet type textfield
                  DropdownButtonFormField(
                    value: _dietTypeController,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your diet type';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      _dietTypeController = newValue!;
                    },
                    items: _dietTypeDropDown
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    decoration: inputDecoration.copyWith(hintText: 'Diet type'),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'Please select your weekly gain/loss target',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  // Target textfield
                  DropdownButtonFormField(
                    value: _targetController,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your target';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      _targetController = newValue!;
                    },
                    items: _targetDropDown
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    decoration:
                        inputDecoration.copyWith(hintText: 'Target per week'),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Add recipe button
            GestureDetector(
              onTap: () async {
                setState(() {
                  saveError = '';
                });
                if (_formKey.currentState!.validate()) {
                  dynamic result = context.read<DietPlanProvider>().updateDietPlan(
                    _ageController.text.trim(),
                    _heightController.text.trim(),
                    _weightController.text.trim(),
                    _sexController.trim(),
                    _activityLevelController.trim(),
                    _dietTypeController.trim(),
                    _targetController.trim()
                  );

                  if (result is Exception) {
                    setState(() {
                      saveError = 'Error when adding the diet plan';
                    });
                  } else {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => CustomBottomSheet().createCustomBottomSheet('Successfully created a diet plan')));
                    //Navigator.pop(context);
                    clearControllers();
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Save diet plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Save error
            Text(
              saveError,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30)
          ]),
        ),
      ))),
    );
  }

  void clearControllers() {
    _ageController.clear();
    _heightController.clear();
    _weightController.clear();
  }

}
