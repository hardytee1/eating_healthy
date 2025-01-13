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
    'I am fine with anything',
  ];

  DropdownButtonFormField<String> buildDropdown({
    required String label,
    required List<String> items,
    required String? value,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Preferences'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                    helperText: 'Enter your age (e.g., 25)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age <= 0 || age > 120) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _age = int.tryParse(value!);
                  },
                ),
                SizedBox(height: 20),

                buildDropdown(
                  label: 'Gender',
                  items: ['Male', 'Female', 'Other'],
                  value: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                buildDropdown(
                  label: 'Are you on a diet?',
                  items: _dietOptions,
                  value: _dietPreference,
                  onChanged: (value) {
                    setState(() {
                      _dietPreference = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a diet preference';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                buildDropdown(
                  label: 'Allowed Food',
                  items: _foodOptions,
                  value: _allowedFood,
                  onChanged: (value) {
                    setState(() {
                      _allowedFood = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select allowed food type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Preferences saved!')),
                        );
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
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}