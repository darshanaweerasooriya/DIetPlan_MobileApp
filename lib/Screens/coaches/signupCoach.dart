import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/coaches/loginCoach.dart';
import 'package:healthbiteapp/components/coaches/coacchtab.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class signupCoach extends StatefulWidget {
  const signupCoach({super.key});

  @override
  State<signupCoach> createState() => _signupCoachState();
}

class _signupCoachState extends State<signupCoach> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController useremail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phnum = TextEditingController();
  bool _isNotvalidate = false;

  Future<void> signUp() async {
    if (usernameController.text.isEmpty ||
        useremail.text.isEmpty ||
        password.text.isEmpty ||
        phnum.text.isEmpty) {
      setState(() {
        _isNotvalidate = true;
      });
      return;
    }

    final Uri uri = Uri.parse('http://10.0.2.2:3001/api/professional/create');
    final Map<String, dynamic> userData = {
      'Username': usernameController.text,
      'Email': useremail.text,
      'password': password.text,
      'phonenumb': phnum.text,
    };

    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode(userData),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully registered!')),
        );
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => coachTab()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to register. ${jsonDecode(response.body)['message'] ?? 'Please try again.'}')),
        );
      }
    } catch (error) {
      print('Error registering: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please check your connection.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "images/Dean-Dark-8.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(31.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  color: Colors.white,
                  child: ListView(
                    padding: const EdgeInsets.only(top: 10),
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20, height: 40),
                          Text(
                            "Welcome ! ",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "Let’s reach your goal with us!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "Register to stay Fit and Healthy",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      inputField(usernameController, "Enter your username", Icons.person, _isNotvalidate),
                      inputField(useremail, "Enter your email", Icons.email, _isNotvalidate, TextInputType.emailAddress),
                      inputField(password, "Enter your password", Icons.lock, _isNotvalidate, TextInputType.text, true),
                      inputField(phnum, "Enter your phone number", Icons.phone, _isNotvalidate, TextInputType.phone),
                      const SizedBox(height: 25),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 220,
                            child: ElevatedButton(
                              onPressed: signUp,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                              ),
                              child: const Text("Sign Up", style: TextStyle(fontSize: 20, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already a member? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => loginCoach()),
                              );
                            },
                            child: const Text("Sign in", style: TextStyle(color: Colors.blueAccent)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget inputField(TextEditingController controller, String hint, IconData icon, bool isInvalid,
      [TextInputType keyboardType = TextInputType.text, bool obscure = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        height: 50,
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            errorText: isInvalid ? "Enter proper Info" : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(icon, color: Colors.black),
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
        ),
      ),
    );
  }
}