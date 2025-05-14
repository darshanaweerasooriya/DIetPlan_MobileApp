import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/clients/dietplan.dart';
import 'package:healthbiteapp/Screens/clients/exercisePlan.dart';

class results extends StatefulWidget {
  final double dailyCalories;  // Accept dailyCalories as a parameter
  final double protein;        // Accept protein as a parameter
  final double water;          // Accept water as a parameter
  const results({Key? key,
    required this.dailyCalories,
    required this.protein,
    required this.water,}) :  super(key: key);


  @override
  State<results> createState() => _resultsState();
}

class _resultsState extends State<results> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100], // Subtle background color
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              // Row to contain the back button and title
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 30, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Results",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              _buildResultCard("Your daily Calorie intake", "${widget.dailyCalories} kcal", Icons.local_fire_department),
              SizedBox(height: 20),
              _buildResultCard("Your daily Calorie deficit", "500 kcal", Icons.remove_circle_outline),
              SizedBox(height: 20),
              _buildResultCard("Your daily protein intake", "${widget.protein} g", Icons.fastfood),
              SizedBox(height: 20),
              _buildResultCard("Your daily water intake", "${widget.water} L", Icons.water_drop),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton("Diet Plan"),
                  _buildActionButton("Exercise Plan"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label) {
    return Container(
      width: 150,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (label == "Diet Plan") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const deitPlans()), // Navigate to Diet Plan
            );
          } else if (label == "Exercise Plan") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const exercisePlans()), // Navigate to Exercise Plan
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.black, // To use gradient
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}