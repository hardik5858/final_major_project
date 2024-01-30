import 'dart:async';

import 'package:final_major_project/page/home_screen.dart';
import 'package:final_major_project/page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    Timer(Duration(seconds: 200), () {
      if (FirebaseAuth.instance.currentUser != null) {
        print(FirebaseAuth.instance.currentUser?.uid);
        final currentUser = FirebaseAuth.instance.currentUser;
        String? ui = currentUser?.uid;
        String? em = currentUser?.email;
        print("uid $ui and $em");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login_Page()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          "animation/LottieLogo1.json",
          height: 200,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Bus Ticket",
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(35.0),
          child: Text(
            "The bus never judges, it just transports you to your destination.",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        )
      ],
    ));
  }
}
