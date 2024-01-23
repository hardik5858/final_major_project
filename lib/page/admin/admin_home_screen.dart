import 'package:final_major_project/page/admin/bus_ticket_data.dart';
import 'package:flutter/material.dart';

class Admin_Home_Screen extends StatefulWidget {
  const Admin_Home_Screen({super.key});

  @override
  State<Admin_Home_Screen> createState() => _Admin_Home_ScreenState();
}

class _Admin_Home_ScreenState extends State<Admin_Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {  
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Add_Bus_Data()));
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
