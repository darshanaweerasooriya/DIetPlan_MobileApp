import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/clients/results.dart';
import 'package:healthbiteapp/Screens/coaches/details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class addDetailsCoach extends StatefulWidget {
  const addDetailsCoach({super.key});

  @override
  State<addDetailsCoach> createState() => _addDetailsCoachState();
}

class _addDetailsCoachState extends State<addDetailsCoach> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  String? _gender;
  final List<String> _selectedTargets = [];
  final List<String> _targets = ['Weight Loss', 'Body Building', 'Fitness'];

  bool _isLoading = false;

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate() || _gender == null || _selectedTargets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse('http://localhost:3001/api/professionals/create');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": "Darshana",
        "username": "darshana123",
        "password": "password123",
        "email": "darshana@example.com",
        "phonenumb": "0711234567",
        "type": 1,
        "age": int.tryParse(ageController.text),
        "height": int.tryParse(heightController.text),
        "weight": int.tryParse(weightController.text),
        "gender": _gender,
        "services": _selectedTargets,
        "qualifications": qualificationController.text,
        "about": aboutController.text,
      }),
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );

      final coachData = {
        "name": "Darshana",
        "username": "darshana123",
        "email": "darshana@example.com",
        "phonenumb": "0711234567",
        "age": int.tryParse(ageController.text),
        "height": int.tryParse(heightController.text),
        "weight": int.tryParse(weightController.text),
        "gender": _gender,
        "services": _selectedTargets,
        "qualifications": qualificationController.text,
        "about": aboutController.text,
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoachDetailsResultScreen(coachData: coachData),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create account: ${response.body}")),
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
      appBar: AppBar(
        title: const Text("Add Coach Details"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildInputField("Age", ageController),
              _buildInputField("Height (cm)", heightController),
              _buildInputField("Weight (kg)", weightController),
              const SizedBox(height: 12),
              const Text("Gender", style: TextStyle(fontWeight: FontWeight.bold)),
              RadioListTile<String>(
                title: const Text('Male'),
                value: 'Male',
                groupValue: _gender,
                onChanged: (value) => setState(() => _gender = value),
              ),
              RadioListTile<String>(
                title: const Text('Female'),
                value: 'Female',
                groupValue: _gender,
                onChanged: (value) => setState(() => _gender = value),
              ),
              const SizedBox(height: 12),
              const Text("Target Services", style: TextStyle(fontWeight: FontWeight.bold)),
              ..._targets.map(_buildTargetCheckbox).toList(),
              _buildInputField("Qualifications", qualificationController),
              _buildInputField("About", aboutController, maxLines: 3),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                icon: const Icon(Icons.save_alt),
                label: const Text("Submit", style: TextStyle(color: Colors.white),),
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.teal,
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}