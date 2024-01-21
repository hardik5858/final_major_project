import 'package:final_major_project/firebase_options.dart';
import 'package:final_major_project/page/admin/admin_home_page.dart';
import 'package:final_major_project/page/admin/login_admin.dart';
import 'package:final_major_project/page/home_page.dart';
import 'package:final_major_project/page/login_page.dart';
import 'package:final_major_project/page/registration_page.dart';
import 'package:final_major_project/page/splash_screen.dart';
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


      home:Admin_Home_Page(),
      routes: {
        MyRoutes.homepage:(context)=>HomePage(),
        MyRoutes.registrationpage:(context)=>Registration_Page(),
        MyRoutes.loginpage:(context)=>Login_Page()
      },
    );
  }
}
OutlineInputBorder defaultOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide(color: Color(0xFFF3F3F3)),
);