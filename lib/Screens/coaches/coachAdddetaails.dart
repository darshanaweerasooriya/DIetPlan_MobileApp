import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/clients/results.dart';


class addDetailsCoach extends StatefulWidget {
  const addDetailsCoach({super.key});

  @override
  State<addDetailsCoach> createState() => _addDetailsCoachState();
}

class _addDetailsCoachState extends State<addDetailsCoach> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController targetDateController = TextEditingController();

  String _gender = 'Male';
  List<String> _selectedTargets = [];

  Future<void> submitData() async {
    // Example output
    print('Age: ${ageController.text}');
    print('Height: ${heightController.text}');
    print('Weight: ${weightController.text}');
    print('Gender: $_gender');
    print('Selected Services: $_selectedTargets');
    print('Daily Status: ${statusController.text}');
    print('Target Date: ${targetDateController.text}');

    // Navigate to results screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const results()),
    );
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
            _buildInputField(
              controller: ageController,
              hint: "e.g. 25",
              icon: Icons.calendar_today,
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel("Height (cm)"),
                      _buildInputField(
                        controller: heightController,
                        hint: "e.g. 170",
                        icon: Icons.height,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel("Weight (kg)"),
                      _buildInputField(
                        controller: weightController,
                        hint: "e.g. 70",
                        icon: Icons.monitor_weight,
                      ),
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
            _fieldLabel("Service "),
            Column(
              children: [
                _buildCheckbox("Body Building"),
                _buildCheckbox("Weight Loss"),
              ],
            ),

            SizedBox(height: 20),
            _fieldLabel("Qualifications"),
            _buildInputField(
              controller: targetDateController,
              hint: "",
              icon: Icons.add,
            ),


            SizedBox(height: 20),
            _fieldLabel("About"),
            TextField(
              controller: statusController,
              decoration: InputDecoration(
                hintText: "About",
                prefixIcon: Icon(Icons.details),
                border: OutlineInputBorder(),
              ),
              maxLines: 4, // You can adjust this to however many lines you want
            ),


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
                  child: Text("Submit",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
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

  Widget _radioGroup({
    required List<String> options,
    required String selectedValue,
    required Function(String) onChanged,
  }) {
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

  Widget _buildCheckbox(String label) {
    return CheckboxListTile(
      title: Text(label),
      value: _selectedTargets.contains(label),
      onChanged: (bool? value) {
        setState(() {
          if (value == true) {
            _selectedTargets.add(label);
          } else {
            _selectedTargets.remove(label);
          }
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}