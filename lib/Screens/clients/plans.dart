import 'package:flutter/material.dart';


class plans extends StatefulWidget {
  const plans({super.key});

  @override
  State<plans> createState() => _plansState();
}

class _plansState extends State<plans> {
  final List<Map<String, String>> exercises = [
    {'image': 'images/splash.jpg', 'title': 'Cycling', 'duration': '20 Minutes'},
    {'image': 'images/splash.jpg', 'title': 'Push Ups', 'duration': '15 Minutes'},
    {'image': 'images/splash.jpg', 'title': 'Yoga', 'duration': '30 Minutes'},
    {'image': 'images/splash.jpg', 'title': 'Treadmill', 'duration': '25 Minutes'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeaderImage(),
            const SizedBox(height: 24),
            _buildMealTabs(),
            const SizedBox(height: 24),
            _buildExerciseList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        "images/foods.jpg",
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }

  Widget _buildMealTabs() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: const TabBar(
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blueAccent,
              tabs: [
                Tab(text: 'Breakfast'),
                Tab(text: 'Lunch'),
                Tab(text: 'Dinner'),
              ],
            ),
          ),
          const SizedBox(
            height: 150,
            child: TabBarView(
              children: [
                Center(child: Text("Oatmeal, Eggs, Coffee", style: TextStyle(fontSize: 16))),
                Center(child: Text("Rice, Chicken, Salad", style: TextStyle(fontSize: 16))),
                Center(child: Text("Soup, Bread, Vegetables", style: TextStyle(fontSize: 16))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Exercise Schedule", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: exercises.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      exercise['image']!,
                      height: 55,
                      width: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exercise['title']!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      Text(exercise['duration']!,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}