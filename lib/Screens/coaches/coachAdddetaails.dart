import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/clients/results.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class addDetailsCoach extends StatefulWidget {
  const addDetailsCoach({super.key});

  @override
  State<addDetailsCoach> createState() => _addDetailsCoachState();
}

class _addDetailsCoachState extends State<addDetailsCoach> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  String? _gender;
  final List<String> _selectedTargets = [];

  final List<String> _targets = ['Weight Loss', 'Body Building', 'Fitness'];

  void _submitData() async {
    final url = Uri.parse('http://localhost:3001/api/professionals/create'); // Replace with your backend URL

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": "Darshana",
        "username": "darshana123",
        "password": "password123",
        "email": "darshana@example.com",
        "phonenumb": "0711234567",
        "type": 1,  // Example: 1 for coach

        // Form data
        "age": int.tryParse(ageController.text),
        "height": int.tryParse(heightController.text),
        "weight": int.tryParse(weightController.text),
        "gender": _gender,
        "services": _selectedTargets,
        "qualifications": qualificationController.text,
        "about": aboutController.text,
      }),
    );

    if (response.statusCode == 201) {
      print("Account created successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );
    } else {
      print("Error: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create account")),
      );
    }
  }

  Widget _buildTargetCheckbox(String target) {
    return CheckboxListTile(
      title: Text(target),
      value: _selectedTargets.contains(target),
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _selectedTargets.add(target);
          } else {
            _selectedTargets.remove(target);
          }
        });
      },
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    qualificationController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Coach Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Height (cm)"),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Weight (kg)"),
            ),
            const SizedBox(height: 10),
            const Text("Gender"),
            ListTile(
              title: const Text('Male'),
              leading: Radio<String>(
                value: 'Male',
                groupValue: _gender,
                onChanged: (value) => setState(() => _gender = value),
              ),
            ),
            ListTile(
              title: const Text('Female'),
              leading: Radio<String>(
                value: 'Female',
                groupValue: _gender,
                onChanged: (value) => setState(() => _gender = value),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Target Services"),
            ..._targets.map(_buildTargetCheckbox).toList(),
            TextField(
              controller: qualificationController,
              decoration: const InputDecoration(labelText: "Qualifications"),
            ),
            TextField(
              controller: aboutController,
              decoration: const InputDecoration(labelText: "About"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}