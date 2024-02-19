// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:final_major_project/page/confirm%20ticket.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// class Select_User_Ticket extends StatefulWidget {
//   String Bus_Ticket_Document;
//   Select_User_Ticket({super.key,required this.Bus_Ticket_Document});
//
//
//   @override
//   State<Select_User_Ticket> createState() => _Select_User_TicketState(Bus_Ticket_Document: Bus_Ticket_Document);
// }
//
// class _Select_User_TicketState extends State<Select_User_Ticket> {
//   _Select_User_TicketState({required this.Bus_Ticket_Document});
//   String Bus_Ticket_Document;
//   Color selectColor=Colors.red;
//   Color booked=Colors.grey;
//   Color available=Colors.green;
//
//   List<String> matchedIndexes=[];
//   List<String> current_bookedticket=[];
//   List<String> totalBookedTicket=[];
//
//   // firebase
//
//   var ticket_connection;
//
//   @override
//   void initState(){
//     // TODO: implement initState
//     super.initState();
//     print(Bus_Ticket_Document);
//     featchData();
//   }
//   Future<void> featchData() async{
// print("hello");
//     try{
//           ticket_connection=await FirebaseFirestore.instance.collection("bus_Time_Table").doc(Bus_Ticket_Document).get();
//
//           if(ticket_connection != null && ticket_connection.exists){
//               print("acc");
//               List<String> rawList=ticket_connection['booked'];
//               print(rawList);
//               List<int> parsedList = rawList.map((item) => item as int).toList();
//               print(parsedList);
//               setState(() {
//                 totalBookedTicket=parsedList.map((e) => e.toString()).toList();
//               });
//               print(totalBookedTicket);
//           }
//     }catch (e){
//
//     }
// print(totalBookedTicket);
//
//     print(ticket_connection['from']);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Select Seats",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//             SizedBox(height: 4,),
//             Row(
//               children: [
//                 Text(ticket_connection != null ? ticket_connection['from'] : '',style: TextStyle(fontSize: 15,color: Colors.grey),),
//                 Icon(
//                   Icons.arrow_forward,
//                   size: 20,
//                   color: Colors.grey,
//                 ),
//                 Text(ticket_connection != null ? ticket_connection['to'] : '',style: TextStyle(fontSize: 15,color: Colors.grey),),
//               ],
//             )
//
//           ],
//         )
//       ),
//       backgroundColor: Color.fromARGB(255, 244, 244, 244),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.longestSide,
//               padding: EdgeInsets.symmetric(horizontal:20,vertical: 20 ),
//               margin: EdgeInsets.only(top: 40,left: 20,right: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20)
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                     Container(
//                       width: 15,
//                       height: 15,
//                       margin: EdgeInsets.only(right: 10,),
//                       decoration: BoxDecoration(
//                         color: available
//                       ),
//                     ),
//                       Text("Available ${int.parse(ticket_connection['sit'])-totalBookedTicket.length}")
//                     ],
//                   ),
//                   SizedBox(height: 5,),
//                   Row(
//                     children: [
//                       Container(
//                         width: 15,
//                         height: 15,
//                         margin: EdgeInsets.only(right: 10,bottom: 5),
//                         decoration: BoxDecoration(
//                             color: selectColor
//                         ),
//                       ),
//                       Text("Selected"+"   "+"${current_bookedticket.length}")
//                     ],
//                   ),
//                   SizedBox(height: 5,),
//                   Row(
//                     children: [
//                       Container(
//                         width: 15,
//                         height: 15,
//                         margin: EdgeInsets.only(right: 10,bottom: 5),
//                         decoration: BoxDecoration(
//                             color: booked
//                         ),
//                       ),
//                       Text("Booked"+"  "+"${totalBookedTicket.length}")
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height* 0.7,
//               width: MediaQuery.of(context).size.longestSide,
//               padding: EdgeInsets.symmetric(horizontal:20,vertical: 30 ),
//               margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child:Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                               border: Border.all(
//                                   width: 2,
//                                   color: Colors.grey
//                               ),
//                               boxShadow: [BoxShadow(
//                                   blurRadius: 2,
//                                   color: Colors.red
//                               )]
//                           ),
//                           child: Center(child: Image.asset("assets/image/steering.png",width: 30,height: 30,))),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//
//                     Text("————2————",style: TextStyle(fontWeight: FontWeight.bold),),
//                       SizedBox(width: 40,),
//                       Text("———————3———————",style: TextStyle(fontWeight: FontWeight.bold))
//                   ],),
//                   SizedBox(height:10,),
//                   Expanded(
//                     child: GridView.builder(
//                       itemCount: int.parse(ticket_connection['sit']),
//                         gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 5,
//                           crossAxisSpacing: 20.0,
//                           mainAxisSpacing: 10.0,
//                         ),
//                         itemBuilder: (context,index){
//                               return GestureDetector(
//                                 onTap: (){
//                                   print(index);
//                                   if(!matchedIndexes.contains(index)){
//                                     select_tapped(index);
//                                     print("slect $index");
//                                   }
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                       color: Colors.white,
//                                     border: Border.all(
//                                       width: 2,
//                                       color: Colors.grey
//                                     ),
//                                     boxShadow: [BoxShadow(
//                                       blurRadius: 3,
//                                       color: totalBookedTicket.contains("$index") ? booked : matchedIndexes.contains("$index") ? selectColor : available,
//                                     )]
//                                   ),
//                                             child:  Center(
//                                               child: Column(
//                                                 children: <Widget>[
//                                                     // if(index==0)
//                                                     //   Text("C",style: TextStyle(fontSize: 30,color: Colors.black),),
//                                                     //  if(index!=0)
//                                                     //    Image.asset("assets/image/seat-selection.png",width: 30,height: 30,color: Colors.green,),
//                                                     //   if(index!=0)
//                                                     //     Text(/*index!=0? */"$index"/*: "C"*/,
//                                                     //       style: TextStyle(fontSize: 10,color: Colors.black),),
//
//                                                       Image.asset("assets/image/seat-selection.png",width: 30,height: 30,color: totalBookedTicket.contains("$index") ? booked : matchedIndexes.contains("$index") ? selectColor : Colors.green,),
//                                                       Text(index!=0? "$index": "C",
//                                                         style: TextStyle(fontSize: 10,color: Colors.black),),
//                                                 ],
//                                               ),
//                                             ),
//                                   ),
//                               );
//                         }),
//                   ),
//                 ],
//               )
//             ),
//             SizedBox(height: 20,),
//             InkWell(
//               onTap: (){
//                 selectTicket SelectTicket=selectTicket(current_bookedticket, totalBookedTicket);
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Confirm_Ticket(Bus_Ticket_Document: Bus_Ticket_Document, SelectTicket: SelectTicket)));
//               print("$Bus_Ticket_Document");
//               print(SelectTicket.totalBookedTicket);
//               print(SelectTicket.current_bookedticket);
//               },
//               child: Container(
//                 height: 50,
//                 width: 140,
//                 margin: EdgeInsets.only(bottom: 30),
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 115, 227, 99),
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(
//                     width: 2,
//                     color: Colors.grey
//                   )
//                 ),
//                 child: Center(child: Text("Book Ticket",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   void  select_tapped(int index){
//     if(!totalBookedTicket.contains("$index")){
//       setState(() {
//         if(matchedIndexes.contains("$index")){
//           matchedIndexes.remove("$index");
//           current_bookedticket.remove("$index");
//         }else{
//           matchedIndexes.add("$index");
//           current_bookedticket.add("$index");
//         }
//       });
//     }
//   }
// }
//
// class selectTicket{
//   List<String> current_bookedticke;
//   List<String> totalBookedTicke;
//   List<int> current_bookedticket(){
//     return current_bookedticke.map((String str) => int.parse(str)).toList();
//   }
//   List<int> totalBookedTicket(){
//     return totalBookedTicke.map((String str) => int.parse(str)).toList();
//   }
//
//
//   selectTicket(this.current_bookedticke,this.totalBookedTicke);
// }