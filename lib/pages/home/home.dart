import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:roomandu/controller/recommendation_controller.dart';
import 'package:roomandu/pages/Screens/explore.dart';
import 'package:roomandu/pages/Screens/mainpage/mainPage.dart';
import 'package:roomandu/pages/Screens/profile.dart';
import 'package:roomandu/pages/home/bottom_app_bar.dart';
import 'package:roomandu/provider/bottom_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final RecommendationController c = Get.put(RecommendationController());
  
  final List<Widget> _screens =[
    MainPage(),
    Explore(),
    Profile(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.recommend();
  }
  
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return WillPopScope(
      onWillPop: () => _willPopContainer(context),
      
      child: Scaffold(
          body: PageTransitionSwitcher(
              transitionBuilder: (child, primaryAnimation, secondaryAnimation){
                return FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
            child: _screens[provider.currentIndex],
          ),
          
          bottomNavigationBar: BottomAppBarContainer(),
        ),
    );
  }

// ignore: always_declare_return_types
 Future<bool> _willPopContainer(BuildContext context){
 return showModal<bool>(
     configuration: FadeScaleTransitionConfiguration(),
     context: context,
      builder: (c) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning,
            color: Colors.redAccent,
            ),
            Text("Leaving page??"),
          ],
        ),
        content: Text("Are you sure want to Leave??"),
        actions: [
          FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () => SystemNavigator.pop(),
              child: Text('Yes')),
  
          FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              color: Colors.lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () => Navigator.pop(c, false),
              child: Text('No')),
        ],
      ),
 );
}
}
