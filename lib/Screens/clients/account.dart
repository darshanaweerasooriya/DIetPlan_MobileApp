import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  String username = '';
  String email = '';
  String phoneNumber = '';
  String profileImage = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isEmpty) {
      // Handle missing token
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3001/api/users/profile/:id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body)['user'];
        setState(() {
          username = userData['username'] ?? '';
          email = userData['email'] ?? '';
          phoneNumber = userData['phonenumber'] ?? '';
          profileImage = userData['profileImage'] ?? '';
        });
      } else {
        print('Error fetching profile: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacementNamed(context, '/login');
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
                      "My Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      child: const Text("Log Out", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Profile Image
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImage.isNotEmpty
                        ? NetworkImage(profileImage)
                        : AssetImage("images/useraccnt.png") as ImageProvider,
                  ),
                ),
                const SizedBox(height: 10),

                // Edit button
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to edit screen
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

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.category, color: Colors.grey[700]),
                  title: Text(
                    "Categories",
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to categories
                  },
                ),
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