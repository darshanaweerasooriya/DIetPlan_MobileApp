import 'package:flutter/material.dart';

class coachAccout extends StatefulWidget {
  const coachAccout({super.key});

  @override
  State<coachAccout> createState() => _coachAccoutState();
}

class _coachAccoutState extends State<coachAccout> {
  @override
  late String username;
  late String email;
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    username = 'Dev User';
    email = 'dev@example.com';
    phoneNumber = '123-456-7890';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Coach Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Log out logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                      child: const Text(
                          "Log Out", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Profile Image
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/useraccnt.png"),
                  ),
                ),
                const SizedBox(height: 10),

                // Edit button
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Edit logic
                    },
                    child: Text(
                      "Edit Account",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Account Info Cards
                _buildInfoCard("Username", username, Icons.person),
                _buildInfoCard("Phone Number", phoneNumber, Icons.phone),
                _buildInfoCard("Email", email, Icons.email),

                const SizedBox(height: 20),
                Divider(),

                // Categories
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                const SizedBox(height: 5),
                Text(value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}