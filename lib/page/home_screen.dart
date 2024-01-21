import 'package:final_major_project/widget/search_bus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_major_project/widget/slider.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 244, 244, 244),
      body: SingleChildScrollView(
        child: Column(
                children: [
                  Search_bus(),
                  SizedBox(
                    height:20,
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 5,
                    indent: 10,
                    endIndent: 10,
                  ),
                  // Slider_Indicator()
                ]
        ),
      )
    );
  }
}