import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/auth/coaches/userLogin.dart';
import 'package:healthbiteapp/Screens/splash/splachScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class signUpCLient extends StatefulWidget {
  const signUpCLient({super.key});

  @override
  State<signUpCLient> createState() => _signUpCLientState();
}

class _signUpCLientState extends State<signUpCLient> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController useremail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phnum = TextEditingController();
  final bool _isNotvalidate = false;

  Future<void> signUp() async {
    final Uri uri = Uri.parse('http://10.0.2.2:3000/registration');
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

      if (response.statusCode == 200) {
        // Successfully registered
        // Navigate to another page or show success message
      } else {
        // Failed to register
        // Show error message or handle accordingly
      }
    } catch (error) {
      print('Error registering: $error');
      // Handle error, show error message or retry logic
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
                  "images/signUp.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child:
              ClipRRect(
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
                          SizedBox(width: 20, height: 40,),
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
                      SizedBox(height: 5),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 20), // Add spacing between text and TextField
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: TextField(
                              controller: usernameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                errorStyle: TextStyle(color: Colors.red),
                                errorText: _isNotvalidate ? "Enter proper Info" : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.person,color: Colors.black,),

                                hintText: 'Enter your username',
                                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 20), // Add spacing between text and TextField
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: TextField(
                              controller: useremail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                errorStyle: TextStyle(color: Colors.red),
                                errorText: _isNotvalidate ? "Enter proper Info" : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.email,color: Colors.black,),
                                hintText: 'Enter your email',
                                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 20), // Add spacing between text and TextField
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: TextField(
                              controller: password,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[150],
                                errorStyle: TextStyle(color: Colors.red),
                                errorText: _isNotvalidate ? "Enter proper Info" : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock, color: Colors.black,),
                                hintText: 'Enter your password',
                                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 20), // Add spacing between text and TextField
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: TextField(
                              controller: phnum,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                errorStyle: TextStyle(color: Colors.red),
                                errorText: _isNotvalidate ? "Enter proper Info" : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.phone,color: Colors.black,),
                                hintText: 'Enter your phone number',
                                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      // Adjust the height of SizedBox here
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),
                          Container(
                            width: 220,
                            child: ElevatedButton(
                              onPressed: signUp,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                              ),
                              child: const Text("Sign Up", style: TextStyle(fontSize: 20, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),
                          Container(
                            width: 220,
                            child: Row(
                              children: [
                                SizedBox(width: 40),
                                Text("Already a member "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                      builder: (context) => clientLogin(),
                                    ));
                                  },
                                  child: Text("Sign in", style: TextStyle(color: Colors.blueAccent)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                ),
              ))
            ],
          ),
        ));
  }
}
