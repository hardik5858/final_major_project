// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:final_major_project/page/home_page.dart';
// import 'package:final_major_project/page/select_ticket.dart';
// import 'package:final_major_project/page/select_ticket_sit.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Confirm_Ticket extends StatefulWidget {
//   String Bus_Ticket_Document;
//   selectTicket SelectTicket;
//
//   Confirm_Ticket(
//       {super.key,
//       required this.Bus_Ticket_Document,
//       required this.SelectTicket});
//
//   @override
//   State<Confirm_Ticket> createState() =>
//       _Confirm_TicketState(this.Bus_Ticket_Document, this.SelectTicket);
// }
//
// class _Confirm_TicketState extends State<Confirm_Ticket> {
//   String Bus_Ticket_Document;
//   selectTicket SelectTicket;
//
//   _Confirm_TicketState(this.Bus_Ticket_Document, this.SelectTicket);
//
//   TextEditingController _passenger_name = TextEditingController();
//   TextEditingController _card_number = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
// // classes
//   CurrentUserData currentUserData = CurrentUserData();
//
// // database instance
//   var currentUserFirestoredata;
//   var cureentUserAuth;
//   var currentTicketDetail;
//
//   @override
//   void initState() {
//     print("hello");
//     super.initState();
//     // user data
//     fetchData();
//
//   }
//
//   Future<void> fetchData() async {
//   try{
//       setState(() async{
//         currentTicketDetail=await FirebaseFirestore.instance.collection("bus_Time_Table").doc(Bus_Ticket_Document).get();
//         cureentUserAuth=await FirebaseAuth.instance.currentUser;
//         currentUserFirestoredata=await FirebaseFirestore.instance.collection("users").doc(cureentUserAuth?.uid).get();
//
//       });
//      print(cureentUserAuth?.uid);
//
//     var i=FirebaseAuth.instance.currentUser;
//     print("${i?.uid} and ${i?.email}");
//     // currentUserFirestoredata=FirebaseFirestore.instance.collection("users").doc(cureentUserAuth?.id)
//   }catch(e){
//
//   }
//   }
//     void addUserSiteData() async{
//     try {
//       print("start");
//       var price = SelectTicket
//           .current_bookedticket()
//           .length * int.parse(currentTicketDetail['price']);
//       var booked_ticket_id;
//       var data = <String, dynamic>{
//         "bus_id": Bus_Ticket_Document,
//         "user_id": cureentUserAuth?.uid,
//         "from": currentTicketDetail['from'],
//         "to": currentTicketDetail['to'],
//         "start_time": currentTicketDetail['start_time'],
//         "end_time": currentTicketDetail['end_time'],
//         "price": currentTicketDetail['price'],
//         "total_amount": price,
//         "sit": SelectTicket.current_bookedticket(),
//         "bus_type": currentTicketDetail['bus_type'],
//         "bus_name": currentTicketDetail['bus_name'],
//         "passenger_name": _passenger_name.text,
//         "card_number": _card_number.text
//       };
//       var ticketDataStore = FirebaseFirestore.instance.collection(
//           "booked_ticket_data").add(data).then((value) =>print('DocumentSnapshot added with ID: ${value}')
//       );
//       print("second");
//       var avilable_sit = int.parse(currentTicketDetail['sit']) - SelectTicket
//           .current_bookedticket()
//           .length;
//       var data2 = <String, dynamic>{
//         "available": avilable_sit,
//         "booked": SelectTicket.current_bookedticket()
//       };
//       await FirebaseFirestore.instance.collection("bus_Time_Table").doc(
//           Bus_Ticket_Document).set(data, SetOptions(merge: true));
//
//       Timer(Duration(seconds: 2), () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => HomePage()));
//       });
//     }catch(e){
//
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Ticket Confirm",
//           style: TextStyle(fontWeight: FontWeight.w500),
//         ),
//       ),
//       backgroundColor: Color.fromARGB(255, 244, 244, 244),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Name",
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       height: 60,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Color.fromARGB(255, 248, 232, 233)),
//                       child: TextFormField(
//                         controller: _passenger_name,
//                         // autofocus: true,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             prefixIcon: Icon(Icons.person),
//                             labelText: "Enter Passenger Name"),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "This Field is Empty";
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         Text("Email id: "),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Color.fromARGB(255, 248, 232, 233)),
//                           child: Text(currentUserFirestoredata?['email'] ?? "not available",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         Text("From: "),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Color.fromARGB(255, 248, 232, 233)),
//                           child: Text( currentTicketDetail != null ? currentTicketDetail['from'] : "not available",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         Text("To: "),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Color.fromARGB(255, 248, 232, 233)),
//                           child: Text(currentTicketDetail != null ? currentTicketDetail['to'] : "not available",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         Text("Start time: "),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Color.fromARGB(255, 248, 232, 233)),
//                           child: Text(
//                             currentTicketDetail?['start_time'] ?? "not available",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         Text("End Time: "),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Color.fromARGB(255, 248, 232, 233)),
//                           child: Text(
//                             currentTicketDetail?['end_time'] ?? "not available",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         Text("Bus Type: "),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Color.fromARGB(255, 248, 232, 233)),
//                           child: Text(
//                             currentTicketDetail?['bus_type'] ?? "not available",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         Text("Select Ticket: "),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Color.fromARGB(255, 248, 232, 233)),
//                           child: Text(SelectTicket.current_bookedticket().toString(),
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Material(
//                 color: Colors.white,
//                 elevation: 8,
//                 borderRadius: BorderRadius.circular(10),
//                 child: InkWell(
//                   splashColor: Colors.black26,
//                   onTap: () {
//                     showModalBottomSheet(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Container(
//                             height: MediaQuery.of(context).size.height * .6,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 20),
//                             decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 248, 232, 233),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(30),
//                                     topRight: Radius.circular(30))),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     margin: EdgeInsets.symmetric(
//                                         horizontal: 10, vertical: 20),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: 5),
//                                     decoration: BoxDecoration(
//                                         color:
//                                             Color.fromARGB(255, 234, 248, 232),
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(
//                                             width: 1, color: Colors.grey)),
//                                     child: Text(
//                                       "Total Amount: ${SelectTicket.current_bookedticket().length * int.parse(currentTicketDetail['price'])}",
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     "Enter Card Number",
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Container(
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color:
//                                             Color.fromARGB(255, 248, 232, 233)),
//                                     child: TextFormField(
//                                       controller: _card_number,
//                                       // autofocus: true,
//                                       keyboardType: TextInputType.number,
//                                       decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10)),
//                                           prefixIcon: Image.asset(
//                                             "assets/image/credit.png",
//                                             height: 30,
//                                             width: 30,
//                                             color: Colors.grey,
//                                           ),
//                                           labelText: "Enter Card Name"),
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return "This Field is Empty";
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 100,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Material(
//                                         color: Colors.white,
//                                         elevation: 8,
//                                         borderRadius: BorderRadius.circular(15),
//                                         child: InkWell(
//                                           splashColor: Colors.black26,
//                                           onTap: () {
//                                               addUserSiteData();
//                                           },
//                                           child: AnimatedContainer(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             duration: Duration(seconds: 500),
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.4,
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.07,
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               "Pay",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 25),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         });
//                   },
//                   child: AnimatedContainer(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     duration: Duration(seconds: 2),
//                     width: MediaQuery.of(context).size.width * 0.4,
//                     height: MediaQuery.of(context).size.height * 0.07,
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Payment",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
//
//
//   // void addTicketData(){
//   //   var data=<String,dynamic>{
//   //     "user":currentUserData.currentUserEmail,
//   //     "uid":currentUserData.currentUserUid,
//   //     "name":_passenger_name.text,
//   //     "price":price().toString(),
//   //     "sit":SelectTicket.current_bookedticket
//   //   };
//   // }
// }
//
// class CurrentUserData {
//   String currentUserUid;
//   String currentUserEmail;
//
//   CurrentUserData({this.currentUserUid = "", this.currentUserEmail = ""});
// }
//
// class CurenntTicketDetail{
// }
