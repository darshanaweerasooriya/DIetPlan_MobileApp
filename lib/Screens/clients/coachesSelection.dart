import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;

class coachesSelection extends StatefulWidget {
  const coachesSelection({super.key});

  @override
  State<coachesSelection> createState() => _coachesSelectionState();
}

class _coachesSelectionState extends State<coachesSelection> {
  TextEditingController  Search = TextEditingController();

  List<Map<String, String>> coaches = [
    {'name': 'James Canning', 'image': 'images/splash.jpg'},
    {'name': 'Alex John', 'image': 'https://via.placeholder.com/150?text=Alex'},
    {'name': 'Harry Brook', 'image': 'https://via.placeholder.com/150?text=Harry'},
    {'name': 'Mark Henry', 'image': 'https://via.placeholder.com/150?text=Mark'},
    {'name': 'John Cameron', 'image': 'https://via.placeholder.com/150?text=John'},
    {'name': 'Alan Root', 'image': 'https://via.placeholder.com/150?text=Alan'},
    {'name': 'Another Coach', 'image': 'https://via.placeholder.com/150?text=Coach'},
    {'name': 'Final Coach', 'image': 'https://via.placeholder.com/150?text=Final'},
  ];

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Online Coaches",
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "SKIP",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text("Select your online coach to guide your ultimate goal!"),
            SizedBox(height: 10),
            TextField(
              controller: Search ,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: Icon(Icons.search, color: Colors.black),
                hintText: 'Search...',
                contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: coaches.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final coach = coaches[index];
                final isSelected = index == selectedIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green[100] : Colors.white,
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              coach['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            coach['name']!,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}