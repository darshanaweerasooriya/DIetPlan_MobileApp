import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/coaches/coachAccount.dart';
import 'package:healthbiteapp/Screens/coaches/coachAdddetaails.dart';
import 'package:healthbiteapp/Screens/coaches/coachMessage.dart';


class coachTab extends StatefulWidget {
  const coachTab({super.key});

  @override
  State<coachTab> createState() => _coachTabState();
}

class _coachTabState extends State<coachTab> {
  int index=0;
  final screen=[
    addDetailsCoach(),
    addDetailsCoach(),
    coachChat(),
    coachAccout()



  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: SafeArea(
          child: Scaffold(
            drawer: Drawer(
              child: Container(
                color: Colors.black,
                child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.settings,color: Colors.white70,),
                        title: Text("Setting",style: TextStyle(color: Colors.white),),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.feedback,color: Colors.white70,),
                        title: Text("Feedback",style: TextStyle(color: Colors.white),),
                      ),
                      ListTile(
                        leading: Icon(Icons.info,color: Colors.white70,),
                        title: Text("About US",style: TextStyle(color: Colors.white),),
                      ),
                      ListTile(
                        title: Text("#####",style: TextStyle(color: Colors.white),),
                      ),
                      ListTile(
                        title: Text("#####",style: TextStyle(color: Colors.white),),
                      ),
                      ListTile(
                        title: Text("#####",style: TextStyle(color: Colors.white),),
                      )
                    ]
                ),
              ),
            ),

            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text("Home",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              )),

            ),
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: Colors.black,
                indicatorColor: Colors.white70,
                labelTextStyle: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14);
                  }
                  return TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14);
                }),
              ),
              child: NavigationBar(
                height: 55,
                selectedIndex: index,
                onDestinationSelected: (index) =>
                    setState(() => this.index=index),


                destinations: [
                  NavigationDestination(icon: Icon(Icons.home,color: Colors.white,), label: "Home"),
                  NavigationDestination(icon: Icon(Icons.add,color: Colors.white,), label: "Add Details"),

                  NavigationDestination(icon: Icon(Icons.chat,color: Colors.white), label: "Chat"),
                  NavigationDestination(icon: Icon(Icons.person,color: Colors.white), label: "Account"),

                ],
              ),

            ),
            body: screen[index],
          ),
        )

    );

  }
}

