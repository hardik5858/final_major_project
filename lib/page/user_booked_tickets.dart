import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_major_project/backend/variable_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class User_Booked_Tickets extends StatefulWidget {
  const User_Booked_Tickets({super.key});

  @override
  State<User_Booked_Tickets> createState() => _User_Booked_TicketsState();
}

class _User_Booked_TicketsState extends State<User_Booked_Tickets> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Tickets"),),
      backgroundColor:Color.fromARGB(255, 244, 244, 244),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("booked_tickets").where('user_uid',isEqualTo: '${Data_Variable.useruid}').snapshots(),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          var documents=snapshot.data?.docs;


          return ListView.builder(
            itemCount: documents?.length,
              itemBuilder: (context,index){
                var documentData =documents?[index].data();
                DateTime dateTime=DateTime.now();
                if(documentData?['store_data']!=null){
                  Timestamp timestamp=documentData?['store_date'];
                  DateTime dateTime=timestamp.toDate();
                }else{
                  dateTime=Data_Variable.selectedDate;
                }
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Passenger Name: ${documentData?['passenger_name']}",style: TextStyle(fontSize: 16),),
                        Text("From: ${documentData?['from']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                        Text("To: ${documentData?['to']}",style: TextStyle(fontSize:16),),
                        Text("Departure: ${documentData?['start_time']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                        Text("Arrival: ${documentData?['end_time']}",style: TextStyle(fontSize: 16),),
                        Text("Bus Type: ${documentData?['bus_type']}",style: TextStyle(fontSize:16)),
                        Text("Bus Name: ${documentData?['bus_name']}",style: TextStyle(fontSize:16)),
                        Text("Card number: ${documentData?['card_number']}",style: TextStyle(fontSize: 16),),
                        Row(
                          children: [
                            Text("Bus tickets",style: TextStyle(fontSize: 16)),
                            for(int i=0;i<documentData?['selected_tickets'].length;i++)
                              Container(
                                padding:EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                margin: EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromARGB(255, 248, 232, 233)),
                                child: Text(documentData!['selected_tickets'][i].toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        Text("Booked_date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime)}",style: TextStyle(fontSize:16)),
                        Text("Bus Ticket id: ${snapshot.data?.docs[index].id}",style: TextStyle(fontSize: 16),),
                        Text("Total Amount: ${documentData?['total_amount']}",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Color.fromARGB(255, 248, 232, 233),
                            color: Data_Variable.buttoncolor
                          ),
                          child: GestureDetector(
                            onTap: (){
                             showDialog(
                               barrierDismissible: true,
                                 context: context,
                                 builder: (BuildContext contex){
                                   return AlertDialog(
                                     title: Text("Cencel Bus"),
                                     elevation: 5,
                                     content: SingleChildScrollView(
                                         child: ListBody(
                                           children: [
                                             Text("Bus Ticket id: ${snapshot.data?.docs[index].id}",style: TextStyle(fontSize: 15,),),
                                             Text("Do You Want To Cancel This Ticket?",style: TextStyle(fontSize: 18,color: Colors.red),)
                                           ],
                                         ),
                                     ),
                                     actions: <Widget>[
                                       TextButton(
                                         child: const Text('No'),
                                         onPressed: () {
                                           Navigator.of(context).pop();
                                         },
                                       ),
                                       TextButton(
                                         child: const Text('Yes'),
                                         onPressed: () {
                                           String Document_id=snapshot.data!.docs[index].id;
                                           String bus_id=documentData?['bus_uid'];
                                           FirebaseFirestore.instance.collection("booked_tickets").doc(Document_id).delete();
                                           FirebaseFirestore.instance.collection("bus_Time_Table").doc(bus_id).update({
                                             'booked':FieldValue.arrayRemove(documentData?['selected_tickets'])
                                           });
                                           ScaffoldMessenger.of(contex).showSnackBar(const SnackBar(
                                               content: Text("Delete Data Successfully")));
                                           Navigator.of(contex).pop();
                                           showDialog(
                                               context: context,
                                               builder:(BuildContext context){
                                                 return AlertDialog(
                                                   content: SingleChildScrollView(
                                                       child: ListBody(
                                                         children: [
                                                           Lottie.asset("animation/payment.json",width: 200,height: 200,repeat: false),
                                                           SizedBox(height: 10,),
                                                           Text("We Refund ${documentData?['total_amount']} for this Passenger ${documentData?['passenger_name']}",style: TextStyle(fontSize: 16),)
                                                         ],
                                                       )),
                                                 );
                                               });
                                           Future.delayed(Duration(seconds: 2), () {
                                             Navigator.of(context).pop();
                                           });
                                         },
                                       ),
                                     ],
                                   );
                                 });
                            },
                            child: Center(
                              child: Text(
                                "Cencel",style: TextStyle(fontSize: 16,),
                              ),
                            ),
                          ),
                        )
                  
                      ],
                    ),
                  ),
                );
              }
          );
        },),
    );
  }
}
