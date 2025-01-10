import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  int? _age;
  String? _dietPreference;
  String? _allowedFood;

  final List<String> _dietOptions = [
    'None',
    'Intermittent Fasting',
    'Keto',
    'Low Carb',
    'Mediterranean',
  ];

  final List<String> _foodOptions = [
    'Vegan',
    'Vegetarian',
    'Non-Pork',
    'Non-Beef',
    'None',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Preferences')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Age Input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter your age';
                    return null;
                  },
                  onSaved: (value) {
                    _age = int.tryParse(value!);
                  },
                ),
                SizedBox(height: 20),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Gender'),
                  items: ['Male', 'Female', 'Other'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) return 'Select your gender';
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Diet Preference Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Are you on a diet?'),
                  items: _dietOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _dietPreference = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) return 'Select a diet preference';
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Allowed Food Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Allowed Food'),
                  items: _foodOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _allowedFood = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) return 'Select allowed food type';
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(
                            age: _age!,
                            gender: _gender!,
                            dietPreference: _dietPreference!,
                            allowedFood: _allowedFood!,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
