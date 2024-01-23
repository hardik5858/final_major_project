import 'package:final_major_project/page/admin/admin_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class Admin_Home_Page extends StatefulWidget {
  const Admin_Home_Page({super.key});

  @override
  State<Admin_Home_Page> createState() => _Admin_Home_PageState();
}

class _Admin_Home_PageState extends State<Admin_Home_Page> {
  int _currentIndex=0;
  final List<Widget> _page=[
   Admin_Home_Screen(),
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
      appBar: AppBar(title: Text("Admin Home Page"),),
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: _page[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 165, 180, 196),
          selectedItemColor: Color.fromARGB(255, 0, 0, 0),
          unselectedItemColor: Color.fromARGB(255, 79, 79, 79),
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex=index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
              label: "Home"
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.directions_bus),
                label: "Ticket"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label:"Account"
            ),
          ],
        ),
      ),
    );
  }
}
