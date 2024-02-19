import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_major_project/backend/variable_data.dart';
import 'package:flutter/material.dart';

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

                return Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "From:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 248, 232, 233),
                                ),
                                child: Text("${documentData?['from']}",
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w500))
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "TO:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromARGB(255, 248, 232, 233),
                                  ),
                                  child: Text("${documentData?['to']}",
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w500))
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${documentData?['start_time']} —",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text("  ${documentData?['end_time']}",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w500))
                            ],
                          ),
                          Text("₹ ${documentData?['total_amount']}",
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Select Ticket: "),
                          for(int i=0;i<documentData?['selected_tickets'].length;i++)
                            Container(
                              padding:EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 248, 232, 233)),
                              child: Text(documentData!['selected_tickets'][i].toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Bus Type :",
                              style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 248, 232, 233),
                            ),
                            child: Text(" ${documentData?['bus_type']} ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Bus Name : ${documentData?['bus_name']}",
                            style: TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 248, 232, 233),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            String Document_id=snapshot.data!.docs[index].id;
                            String bus_id=documentData?['bus_uid'];
                            FirebaseFirestore.instance.collection("booked_tickets").doc(Document_id).delete();
                            FirebaseFirestore.instance.collection("bus_Time_Table").doc(bus_id).update({
                              'booked':FieldValue.arrayRemove(documentData?['selected_tickets'])
                            });
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Delete Data Successfully")));
                          },
                          child: Center(
                            child: Text(
                              "Cencel",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        },),
    );
  }
}
