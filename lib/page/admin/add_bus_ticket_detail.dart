import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'bus_ticket_data.dart';

class Bus_Ticket_Detail extends StatefulWidget {
  const Bus_Ticket_Detail({super.key});

  @override
  State<Bus_Ticket_Detail> createState() => _Bus_Ticket_DetailState();
}

class _Bus_Ticket_DetailState extends State<Bus_Ticket_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: StreamBuilder(
        stream:FirebaseFirestore.instance.collection("bus_Time_Table").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          var documents = snapshot.data?.docs;
          return ListView.builder(
              itemCount: documents?.length,
              itemBuilder: (context, index) {
                var documentData = documents?[index].data();
                // Customize this based on your document structure
                String f = snapshot.data!.docs[index].id;

                return Card(
                  // elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(1, 1))
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width:
                              MediaQuery.of(context).size.width / 2 * 0.8,
                              child: Row(
                                children: [
                                  Text("From: "),
                                  Text(
                                    documentData?['from'].toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.arrow_forward),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width:
                              MediaQuery.of(context).size.width / 2 * 0.7,
                              child: Row(
                                children: [
                                  Text("To: "),
                                  Text(
                                    documentData?['to'].toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              width:
                              MediaQuery.of(context).size.width / 2 * 0.8,
                              child: Row(
                                children: [
                                  Text("Departure: "),
                                  Text(
                                    documentData?['start_time'].toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.access_time_outlined),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width:
                              MediaQuery.of(context).size.width / 2 * 0.7,
                              child: Row(
                                children: [
                                  Text("Arrival: "),
                                  Text(
                                    documentData?['end_time'].toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 * 0.8,
                              child: Row(
                                children: [
                                  Text("Bus: "),
                                  Expanded(
                                    child: Text(
                                      documentData?['bus_type'].toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.currency_rupee),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width:
                              MediaQuery.of(context).size.width / 2 * 0.7,
                              child: Row(
                                children: [
                                  Text("Price: "),
                                  Text("${documentData?['price']}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("Bus Name :"),
                            Text(documentData?['bus_name'].toUpperCase() ?? "null",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              width:
                              MediaQuery.of(context).size.width / 2 * 0.8,
                              child: Row(
                                children: [
                                  Text("Total Sits:"),
                                  Text("${documentData?['sit']}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.arrow_forward),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 * 0.7,
                              child: Row(
                                children: [
                                  Text("Available: "),
                                  Text("00"
                                    ,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                String Document_id=snapshot.data!.docs[index].id;
                                FirebaseFirestore.instance.collection("bus_Time_Table").doc(Document_id).delete();
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Delete Data Successfully"),
                                ));
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Admin_Add_Bus_Data()));
        },
        child: Icon(Icons.add),
      ),
    );;
  }
}
