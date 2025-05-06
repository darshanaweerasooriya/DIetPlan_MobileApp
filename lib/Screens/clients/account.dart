import 'package:flutter/material.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  late String username;
  late String email;
  late String phoneNumber;

  @override
  void initState() {
    super.initState();

    // TEMP: Dummy data for development/testing
    username = 'Dev User';
    email = 'dev@example.com';
    phoneNumber = '123-456-7890';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bkrr.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      // Log Out logic
                    },
                    child: const Text(
                      "Log Out",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 10),
                  Image.asset("images/useraccnt.png", width: 100),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      // Edit Account logic
                    },
                    child: Text(
                      "Edit Account",
                      style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    username,
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: 370,
                    height: 50,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              phoneNumber,
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: 370,
                    height: 50,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              email,
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Categories
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
