import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/clients/message.dart';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';


class coachesSelection extends StatefulWidget {
  const coachesSelection({super.key});

  @override
  State<coachesSelection> createState() => _coachesSelectionState();
}

class _coachesSelectionState extends State<coachesSelection> {
  TextEditingController search = TextEditingController();

  List<dynamic> allCoaches = [];
  List<dynamic> filteredCoaches = [];

  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    fetchCoaches();
  }

  Future<void> fetchCoaches() async {
    final List<Map<String, dynamic>> sampleCoaches = [
      {
        'name': 'Coach lee',
        'type': 1,
        'profileImage': '',
        'status': 'Available',
      },
      {
        'name': 'Coach Chaminda',
        'type': 1,
        'profileImage': '',
        'status': 'Busy',
      },
    ];

    setState(() {
      allCoaches = sampleCoaches;
      filteredCoaches = sampleCoaches;
    });

    final url = Uri.parse('http://localhost:3001/api/professionals');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final backendCoaches = data.where((coach) => coach['type'] == 1).toList();
        setState(() {
          allCoaches.addAll(backendCoaches);
          filteredCoaches = allCoaches;
        });
      } else {
        print('Failed to load coaches from backend');
      }
    } catch (e) {
      print('Error fetching backend data: $e');
    }
  }

  void filterSearch(String query) {
    final results = allCoaches.where((coach) {
      final name = coach['name'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredCoaches = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Online Coaches",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("SKIP", style: TextStyle(color: Colors.grey.shade600)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text("Select your online coach to guide your ultimate goal!",
                  style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(height: 20),
              TextField(
                controller: search,
                onChanged: filterSearch,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search coaches...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 20),
              filteredCoaches.isEmpty
                  ? const Center(child: Text("No coaches found"))
                  : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredCoaches.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final coach = filteredCoaches[index];
                  final isSelected = index == selectedIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red[50] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: isSelected ? Colors.redAccent : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.network(
                                coach['profileImage'] != null && coach['profileImage'].toString().isNotEmpty
                                    ? 'http://localhost:3001/${coach['profileImage']}'
                                    : 'https://via.placeholder.com/300x300?text=${coach['name']}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              coach['name'] ?? 'No Name',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: selectedIndex != null
                    ? () {
                  final selectedCoach = filteredCoaches[selectedIndex!];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => onlinePeople(
                        coachName: selectedCoach['name'] ?? '',
                        coachImage: selectedCoach['profileImage'] ?? '',
                        coachStatus: selectedCoach['status'] ?? 'Available',
                      ),
                    ),
                  );
                }
                    : null,
                child: const Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
