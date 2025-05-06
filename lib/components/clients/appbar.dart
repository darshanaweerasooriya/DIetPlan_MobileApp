import 'package:flutter/material.dart';
import 'package:healthbiteapp/Screens/clients/account.dart';
import 'package:healthbiteapp/Screens/clients/addDetails.dart';
import 'package:healthbiteapp/Screens/clients/dashBoard.dart';
import 'package:healthbiteapp/Screens/clients/plans.dart';
import 'package:healthbiteapp/Screens/splash/splachScreen.dart';


class tabbar extends StatefulWidget {
  const tabbar({Key? key}) : super(key: key);

  @override
  State<tabbar> createState() => _tabbarState();
}

class _tabbarState extends State<tabbar> {
  int index=0;
  final screen=[
   dashBoard(),
    addDetails(),
    plans(),
    splashScreen(),
    account()

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
                 title: Text("Home"),

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
                  NavigationDestination(icon: Icon(Icons.dashboard, color: Colors.white), label: "DashBoard"),
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
