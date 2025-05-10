import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/auth/coaches/userSignup.dart';
import 'package:healthbiteapp/components/clients/appbar.dart';
import 'package:healthbiteapp/components/coaches/coacchtab.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class loginCoach extends StatefulWidget {
  const loginCoach({super.key});

  @override
  State<loginCoach> createState() => _loginCoachState();
}

class _loginCoachState extends State<loginCoach> {
  TextEditingController EmailCountoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final bool _isNotvalidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }
  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }
  void loginUser() async {
    // TEMP: Direct navigation for development testing
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => coachTab()),
    );
    return;


  }

  Future<void> loging() async{
    final url = Uri.parse('http://10.0.2.2:3000/login');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'Email': EmailCountoller.text,
          'password': passwordController.text,
        }),
        headers: {'Content-Type': 'application/json'},

      );
      final responseData = json.decode(response.body);
      if (responseData['status']== true){
        print('Login Success');
      }else{
        print('Loging Failed');
      }
    }catch(error){
      print('Error');
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Image.asset(
                  "images/Dean-Dark-8.jpg",
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
                        width: 400,
                        height: 450,
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                      "Welcome Back ! ",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                      "We can secure the health of your health",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                      "for the better future ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    SizedBox(width: 20), // Add spacing between text and TextField
                                    Container(
                                      width: MediaQuery.of(context).size.width - 50,
                                      height: 50,
                                      child: TextField(
                                        controller: EmailCountoller,
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
                                SizedBox(width: 20,height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width: 20), // Add spacing between text and TextField
                                    Container(
                                      width: MediaQuery.of(context).size.width - 50,
                                      height: 50,
                                      child: TextField(
                                        controller: passwordController,
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

                                          prefixIcon: Icon(Icons.password,color: Colors.black,),
                                          hintText: 'Enter your Password',
                                          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8,),
                                Row(

                                  children: [
                                    SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: (){
                                        // Navigator.push(
                                        //     context, MaterialPageRoute(
                                        //     builder: (context) => coachesSelection()
                                        // ));
                                      },
                                      child: Text(
                                        "Forgot Password ?",
                                        style: TextStyle(
                                          color: Colors.blueAccent.shade700,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 30),
                                    // Adjust the height of SizedBox here


                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10),
                                    Container(
                                      width: 220,
                                      child: ElevatedButton(
                                        onPressed: loginUser,
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                              Colors.black),
                                        ),
                                        child: const Text("Sign in", style: TextStyle(fontSize: 20, color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10),
                                    Container(
                                        width: 240,
                                        child:Row(
                                          children: [
                                            SizedBox(width: 20,),
                                            Text("New to HealthBite? "),
                                            GestureDetector(
                                                onTap: (){
                                                  Navigator.push(
                                                      context, MaterialPageRoute(
                                                      builder: (context) => signUpCLient()
                                                  ));

                                                },
                                                child: Text("Sign up",style: TextStyle(color: Colors.blueAccent),))
                                          ],
                                        )
                                    ),
                                  ],
                                ),

                              ],
                            ))
                    ),
                  ))
            ],
          ),
        ));
  }
}


