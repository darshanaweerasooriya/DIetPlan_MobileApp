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
      backgroundColor: Color(0xFFF2F6FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildMetrics(),
              SizedBox(height: 20),
              _buildScrollableStats(),
              SizedBox(height: 20),
              _buildMealTabs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 30, backgroundColor: Colors.blueAccent, child: Text("A", style: TextStyle(color: Colors.white, fontSize: 24))),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Alex Hales", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Age 23", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
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
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: Colors.black54)),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: color),
          Spacer(),
          Text(title, style: TextStyle(fontSize: 16, color: Colors.black87)),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
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
            child: TabBar(
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
          SizedBox(
            height: 200,
            child: TabBarView(
              children: [
                _mealContent("Oatmeal, Eggs, Coffee"),
                _mealContent("Rice, Chicken, Salad"),
                _mealContent("Soup, Bread, Vegetables"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mealContent(String content) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Text(content, style: TextStyle(fontSize: 18, color: Colors.black87)),
    );
  }
}