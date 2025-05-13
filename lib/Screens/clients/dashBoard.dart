import 'package:flutter/material.dart';

class dashBoard extends StatefulWidget {
  const dashBoard({super.key});

  @override
  State<dashBoard> createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildMetrics(),
              const SizedBox(height: 20),
              _buildScrollableStats(),
              const SizedBox(height: 20),
              _buildMealAndExerciseOptions(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blueAccent,
                child: Text("A", style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alex Hales", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("Age 23", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _infoColumn("Height", "186 cm"),
              _infoColumn("Weight", "86 kg"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMetrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _metricCard("Height", "186 cm", Colors.greenAccent),
        _metricCard("Weight", "86 kg", Colors.orangeAccent),
      ],
    );
  }

  Widget _metricCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableStats() {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _statCard("Calories", "2200 kcal", Icons.local_fire_department, Colors.redAccent),
          _statCard("Protein", "120 g", Icons.fitness_center, Colors.deepPurple),
          _statCard("Water", "2.5 L", Icons.water_drop, Colors.blue),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: color),
          const Spacer(),
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMealAndExerciseOptions() {
    return Column(
      children: [
        _navigationTile(
          icon: Icons.article,
          title: "Educational",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MealDetailPage(mealType: "Breakfast")),
          ),
        ),
        const SizedBox(height: 10),
        _navigationTile(
          icon: Icons.health_and_safety_outlined,
          title: "Appointment",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MealDetailPage(mealType: "Lunch")),
          ),
        ),
        const SizedBox(height: 10),
        _navigationTile(
          icon: Icons.dinner_dining,
          title: "Grocery",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MealDetailPage(mealType: "Dinner")),
          ),
        ),
        const SizedBox(height: 10),
        _navigationTile(
          icon: Icons.feedback,
          title: "Feedbacks ",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ExerciseDetailPage()),
          ),
        ),
      ],
    );
  }

  Widget _navigationTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green, size: 30),
            const SizedBox(width: 20),
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class MealDetailPage extends StatelessWidget {
  final String mealType;

  const MealDetailPage({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$mealType Plan')),
      body: Center(
        child: Text('Detailed information about the $mealType meal plan.'),
      ),
    );
  }
}

class ExerciseDetailPage extends StatelessWidget {
  const ExerciseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise Plan')),
      body: const Center(
        child: Text('Detailed information about your Exercise Plan.'),
      ),
    );
  }
}