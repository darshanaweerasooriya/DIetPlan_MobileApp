import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/auth/coaches/userSignup.dart';
import 'package:healthbiteapp/Screens/coaches/loginCoach.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            /// Background Image
            SizedBox.expand(
              child: Image.asset(
                "images/splash.jpg",
                fit: BoxFit.cover,
              ),
            ),

            /// Gradient overlay (optional for premium feel)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            /// Bottom Glass-like Card
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Top Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Text Area
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("WELCOME !!",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  )),
                              const SizedBox(height: 6),
                              Text("Health Bite",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  )),
                              const SizedBox(height: 8),
                              Text("Let’s be a healthy huma with us. join with us ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  )),
                            ],
                          ),
                        ),

                        /// Logo
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(12),
                        //   child: Container(
                        //     width: 80,
                        //     height: 80,
                        //     color: Colors.transparent,
                        //     child: Image.asset(
                        //       "images/logow.png",
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// Users Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => signUpCLient()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: const Text("Users", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),

                    const SizedBox(height: 16),

                    /// Coaches Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => loginCoach()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: const Text("Coaches", style: TextStyle(fontSize: 18,color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
