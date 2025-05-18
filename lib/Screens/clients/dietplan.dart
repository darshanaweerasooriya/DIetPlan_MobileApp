import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class deitPlans extends StatefulWidget {
  const deitPlans({super.key});

  @override
  State<deitPlans> createState() => _deitPlansState();
}

class _deitPlansState extends State<deitPlans> {
  Map<String, dynamic>? dietPlan;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchDietPlan();
  }

  Future<void> fetchDietPlan() async {
    print('⚙️ Starting to fetch diet plan...');
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      print('📦 Retrieved token: $token');

      if (token == null) {
        setState(() {
          isLoading = false;
          errorMessage = '❌ Unauthorized: No token found in SharedPreferences';
        });
        return;
      }

      final uri = Uri.parse('http://10.0.2.2:3001/api/fitnessassess/plan');
      print('🌐 Sending GET request to: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('📨 Status Code: ${response.statusCode}');
      print('📨 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('✅ JSON decoded successfully: $data');

        if (data['plan'] == null) {
          print('❌ "plan" key not found in response.');
          setState(() {
            isLoading = false;
            errorMessage = 'Plan data not found in server response.';
          });
          return;
        }

        setState(() {
          dietPlan = data['plan'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = '❌ Failed to load diet plan: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e, stackTrace) {
      print('🔥 Exception occurred: $e');
      print('🪵 Stack Trace: $stackTrace');
      setState(() {
        isLoading = false;
        errorMessage = 'Exception: $e';
      });
    }
  }


  Widget _buildMealList(List<dynamic> meals) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: Image.network(
              meal['image'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(meal['title']),
            subtitle: Text(
              'Calories: ${meal['calories']} | Protein: ${meal['protein']}g | Fat: ${meal['fat']}g | Carbs: ${meal['carbs']}g',
            ),
          ),
        );
      },
    );
  }

  Widget _buildMealTabs() {
    if (dietPlan == null) {
      return Center(child: Text('No plan found'));
    }

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
          SizedBox(
            height: 300, // adjust as needed
            child: TabBarView(
              children: [
                _buildMealList(dietPlan!['breakfast']),
                _buildMealList(dietPlan!['lunch']),
                _buildMealList(dietPlan!['dinner']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Diet Plan'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildMealTabs(),
      ),
    );
  }
}
