import 'package:final_major_project/firebase_options.dart';
import 'package:final_major_project/page/admin/admin_home_page.dart';
import 'package:final_major_project/page/admin/admin_home_screen.dart';
import 'package:final_major_project/page/admin/login_admin.dart';
import 'package:final_major_project/page/confirm%20ticket.dart';
import 'package:final_major_project/page/home_page.dart';
import 'package:final_major_project/page/login_page.dart';
import 'package:final_major_project/page/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      title: "Ticket Booking",
      theme: ThemeData(
        useMaterial3: true
      ),
      home:Admin_Home_Page(),
      routes: {
        '/user_login_page':(context)=>Login_Page(),
        '/user_registration':(context)=>Registration_Page(),
        '/user_homepage':(context)=>HomePage(),
      },
    );
  }
}
// OutlineInputBorder defaultOutlineInputBorder = OutlineInputBorder(
//   borderRadius: BorderRadius.circular(14),
//   borderSide: const BorderSide(color: Color(0xFFF3F3F3)),
// );
