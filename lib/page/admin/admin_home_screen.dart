import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Text("hello"),
    );
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Row(
// children: [
// Text("From: "),
// SizedBox(
// width: 3,
// ),
// Text(
// documentData?['from'].toUpperCase(),
// style: TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.bold),
// ),
// ],
// ),
// Icon(Icons.arrow_forward),
// Row(
// children: [
// Text("To: "),
// SizedBox(
// width: 3,
// ),
// Text(
// documentData?['to'].toUpperCase(),
// style: TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.bold),
// ),
// ],
// )
// ],
// ),
// SizedBox(
// height: 3,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Row(
// children: [
// Text("Departure: "),
// SizedBox(
// width: 3,
// ),
// Text(
// documentData?['start_time'],
// style: TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.w500),
// )
// ],
// ),
// Icon(Icons.access_time),
// Row(
// children: [
// Text("Arrival: "),
// SizedBox(
// width: 3,
// ),
// Text(
// documentData?['end_time'],
// style: TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.w500),
// )
// ],
// ),
// ],
// ),
// SizedBox(
// height: 3,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Row(
// children: [
// Text("Bus: "),
// SizedBox(
// width: 3,
// ),
// Text(
// documentData?['bus_type'],
// style: TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.w500),
// )
// ],
// ),
// Icon(Icons.currency_rupee),
// Row(
// children: [
// Text("Price: "),
// SizedBox(
// width: 3,
// ),
// Text(
// documentData?['price'],
// style: TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.w500),
// )
// ],
// )
// ],
// ),
// SizedBox(
// height: 3,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Row(
// children: [
// Text("Total Sits:"),
// SizedBox(
// width: 3,
// ),
// Text(
// documentData?['sit'],
// style: TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.w500),
// )
// ],
// ),
// Row(
// children: [
// Text("Available: "),
// SizedBox(
// width: 3,
// ),
// Text(
// "00",
// style: TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.w500),
// )
// ],
// )
// ],
// )
// ],
// )
