import 'package:flutter/material.dart';

class deitPlans extends StatefulWidget {
  const deitPlans({super.key});

  @override
  State<deitPlans> createState() => _deitPlansState();
}

class _deitPlansState extends State<deitPlans> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: ListView(
        children: [

          // _buildMealTabs(),
          // const SizedBox(height: 24),
          // _buildExerciseList(),
          Column(
            children: [
              SizedBox(height: 10,),
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
                    "Diet Plan",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.2,
                    ),
                  ),
              Spacer(),
              Container(
                width: 80, // Equal width and height for square shape
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => signUpCLient()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Optional: for slightly rounded corners
                    ),
                    padding: EdgeInsets.zero, // Remove default padding
                  ),
                  child: Text("Save",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),), // Use an icon or short text
                ),
              ),
      ]


    ),

            ],
          ),
          SizedBox(height: 20,),
          _buildHeaderImage(),
          const SizedBox(height: 24),
          _buildMealTabs(),
          const SizedBox(height: 24),

        ],
      ),
    ));
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
}
