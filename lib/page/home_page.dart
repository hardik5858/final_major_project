
import 'package:final_major_project/page/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex=0;

  final List<Widget> _page=[
    Home_Screen(),
    Container(
      color: Colors.green,
      child: Center(
        child: Text('Page 2'),
      ),
    ),
    Container(
      color: Colors.orange,
      child: Center(
        child: Text('Page 3'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ticket booking"),),
      body: _page[_currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        decoration: BoxDecoration(
            boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 25,
                )
              ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            elevation: 10,
            backgroundColor: Color.fromARGB(255, 236, 236, 236),
              selectedItemColor: Color.fromARGB(255, 9, 9, 9),
              unselectedItemColor: Color.fromARGB(255, 79, 79, 79),
              currentIndex: _currentIndex,
            onTap: (index){
                setState(() {
                  _currentIndex=index;
                });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label:"Home"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.directions_bus),
                  label:"Ticket"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label:"Account"
              ),
            ],
          
          ),
        ),
      ),
    );
  }
}
