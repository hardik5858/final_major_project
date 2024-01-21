import 'dart:async';

import 'package:final_major_project/page/home_screen.dart';
import 'package:final_major_project/page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 2),
        () {
          if (FirebaseAuth.instance.currentUser != null) {
            print(FirebaseAuth.instance.currentUser?.uid);
            final currentUser=FirebaseAuth.instance.currentUser;
            String? ui=currentUser?.uid;
            String? em=currentUser?.email;
            print("uid $ui and $em");
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));
          }else{
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login_Page()));
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
       child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset("assets/image/bus-ticket-icon.jpg"),
        ),
    );
  }
}