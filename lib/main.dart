import 'package:final_major_project/firebase_options.dart';
import 'package:final_major_project/page/home_page.dart';
import 'package:final_major_project/page/login_page.dart';
import 'package:final_major_project/page/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'my_routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ticket Booking",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          primaryColor: Colors.orange
        // useMaterial3: true
      ),
      home: HomePage(),
      routes: {
        MyRoutes.homepage:(context)=>HomePage(),
        MyRoutes.registrationpage:(context)=>Registration_Page(),
        MyRoutes.loginpage:(context)=>Login_Page()
      },
    );
  }
}