import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class addDetails extends StatefulWidget {
  const addDetails({super.key});

  @override
  State<addDetails> createState() => _addDetailsState();
}

class _addDetailsState extends State<addDetails> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController targetDateController = TextEditingController();

  String _gender = 'Male';
  String _target = 'Body Building';

  Future<void> submitData() async {
    final uri = Uri.parse('https://yourapi.com/api/user-details');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'age': ageController.text.trim(),
        'height': heightController.text.trim(),
        'weight': weightController.text.trim(),
        'gender': _gender,
        'target': _target,
        'dailyStatus': statusController.text.trim(),
        'targetDate': targetDateController.text.trim(),
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Details submitted successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit details")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],

        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _sectionTitle("Enter Your Details"),

            _fieldLabel("Age"),
            _buildInputField(controller: ageController, hint: "e.g. 25", icon: Icons.calendar_today),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel("Height (cm)"),
                      _buildInputField(controller: heightController, hint: "e.g. 170", icon: Icons.height),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel("Weight (kg)"),
                      _buildInputField(controller: weightController, hint: "e.g. 70", icon: Icons.monitor_weight),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            _fieldLabel("Gender"),
            _radioGroup(
              options: ['Male', 'Female'],
              selectedValue: _gender,
              onChanged: (val) => setState(() => _gender = val),
            ),

            SizedBox(height: 20),
            _fieldLabel("Target"),
            _radioGroup(
              options: ['Body Building', 'Weight Loss'],
              selectedValue: _target,
              onChanged: (val) => setState(() => _target = val),
            ),

            SizedBox(height: 20),
            _fieldLabel("Daily Status"),
            _buildInputField(controller: statusController, hint: "e.g. Active", icon: Icons.timeline),

            SizedBox(height: 20),
            _fieldLabel("Target Date"),
            _buildInputField(controller: targetDateController, hint: "e.g. 2025-12-31", icon: Icons.date_range),

            SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitData,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Submit", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600));
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String hint, required IconData icon}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.black),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _radioGroup({required List<String> options, required String selectedValue, required Function(String) onChanged}) {
    return Row(
      children: options.map((option) {
        return Row(
          children: [
            Radio<String>(
              value: option,
              groupValue: selectedValue,
              onChanged: (val) => onChanged(val!),
            ),
            Text(option, style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
          ],
        );
      }).toList(),
    );
  }
}