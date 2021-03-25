import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomandu/auth/loginpage.dart';
import 'package:roomandu/introscreen/introduction.dart';
import 'file:///C:/Users/Dell/AndroidStudioProjects/commerce/formvalidate/roomandu/lib/provider/user_repository.dart';
import 'package:roomandu/pages/home/home.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    return ChangeNotifierProvider(
      create: (_) => UserRepository.instance(),
      // ignore: always_specify_types
      child: Consumer(
        builder: (BuildContext context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return IntroductionScreen();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return Home();
          }
          return null;
        },
      ),
    );
  }
}
