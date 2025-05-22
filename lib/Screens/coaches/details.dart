import 'package:flutter/material.dart';

class CoachDetailsResultScreen extends StatelessWidget {
  final Map<String, dynamic> coachData;

  const CoachDetailsResultScreen({super.key, required this.coachData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coach Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Name: ${coachData['name']}"),
            Text("Username: ${coachData['username']}"),
            Text("Email: ${coachData['email']}"),
            Text("Phone: ${coachData['phonenumb']}"),
            Text("Age: ${coachData['age']}"),
            Text("Height: ${coachData['height']} cm"),
            Text("Weight: ${coachData['weight']} kg"),
            Text("Gender: ${coachData['gender']}"),
            Text("Services: ${coachData['services'].join(', ')}"),
            Text("Qualifications: ${coachData['qualifications']}"),
            Text("About: ${coachData['about']}"),
          ],
        ),
      ),
    );
  }
}
