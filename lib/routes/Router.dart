import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:roomandu/auth/loginpage.dart';
import 'package:roomandu/introscreen/introduction.dart';
import 'package:roomandu/pages/AboutUs.dart';
import 'package:roomandu/pages/HomePage.dart';
import 'package:roomandu/pages/home/home.dart';
import 'package:roomandu/widget/my_page_route_builder.dart';

class RouterApp{
static Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case'/':
      return MyPageRouteBuilder(screen: Home()).buildPageRoute();
    case'/homepage':
      return MyPageRouteBuilder(screen: HomePage()).buildPageRoute();
  
    case'/loginpage':
      return MyPageRouteBuilder(screen: LoginPage()).buildPageRoute();

    case'/aboutus':
      return MyPageRouteBuilder(screen: AboutUs()).buildPageRoute();
  
    default:
      return null;
  }
}
}