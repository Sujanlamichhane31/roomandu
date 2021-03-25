
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:roomandu/provider/bottom_navigation_bar.dart';
import 'package:roomandu/provider/currentuser.dart';
import 'package:roomandu/routes/Router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF03A63C),
      ),
    );
    
    return MultiProvider(
      // ignore: always_specify_types
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        ),
        // ignore: always_specify_types
        ChangeNotifierProvider.value(
            value: BottomNavigationBarProvider(),
        )
      ],
      child: ChangeNotifierProvider(
        create: (context) => CurrentUser(),
    child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xFF03A63C)
          ),
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) => RouterApp.generateRoute(settings),

        ),
      ),
    );
  }
}

