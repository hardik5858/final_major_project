import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../backend/variable_data.dart';

class Show_Top_Destination extends StatefulWidget {
  const Show_Top_Destination({super.key});

  @override
  State<Show_Top_Destination> createState() => _Show_Top_DestinationState();
}

class _Show_Top_DestinationState extends State<Show_Top_Destination> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("Top Destination").get(),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          var documents=snapshot.data?.docs;

          return ListView.builder(
              shrinkWrap: true,
              // physics: ClampingScrollPhysics(),
              itemCount:5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                // var documentData =documents?[index].data();
                return Container(
                  width: 200,
                  height: 100,
                  child: Stack(
                    children: [
                      Card(
                        elevation: 5,
                        child: Expanded(
                          child: Container(
                            // width: 100,
                            height: 90,
                            decoration: BoxDecoration(
                                color: Data_Variable.temlatecolor2,
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Container(
                          // width: 100,
                          height: 65,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text(Data_Variable.firstUpre("surat surat"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 30,
                          top: 70,
                          child: Text("₹ 300",style: TextStyle(fontSize: 17),)
                      )
                    ],
                  ),
                );
              }
          );
        });
  }
}
