import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_major_project/widget/search_bus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search_Result_Bus extends StatefulWidget {
  final Search_Data search_data;

  const Search_Result_Bus({super.key, required this.search_data});

  @override
  State<Search_Result_Bus> createState() =>
      _Search_Result_BusState(search_data);
}

class _Search_Result_BusState extends State<Search_Result_Bus> {
  final Search_Data search_data;

  _Search_Result_BusState(this.search_data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              children: [
                Text(
                  search_data.from.text.toUpperCase() + " ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Colors.black54,
                ),
                Text("  ${search_data.to.text.toUpperCase()}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
              ],
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 248, 232, 233),
              ),
              child: Text("${DateFormat("MM-dd ").format(search_data.selectedDate)}"),
            )
          ],
        ),
        backgroundColor: Color.fromARGB(255, 241, 240, 246),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("bus_Time_Table").where('from',isEqualTo: '${search_data.from.text}',).where('to',isEqualTo: '${search_data.to.text}').snapshots(),
          builder:(context,snapshot){
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
                    var documentData = documents?[index].data();
                      return Container(
                        height: 210,
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
                                      "${documentData?['start_time']} —",
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w500),
                                    ),
                                    Text("  ${documentData?['end_time']}",
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.w500))
                                  ],
                                ),
                                Text("₹ ${documentData?['price']}",
                                    style:
                                    TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                              ],
                            ),
                            Text(
                              "${documentData?['sit']}  Seats are available",
                              style: TextStyle(fontSize: 11, color: Colors.green),
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
                              child: Center(
                                child: Text(
                                  "Return trip redDeal : Min 10% off on return ticket",
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                  }
              );
           } ,

    )
    );
  }
}
// Container(
// height: 210,
// padding: EdgeInsets.all(20),
// margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
// decoration: BoxDecoration(
// color: Colors.white, borderRadius: BorderRadius.circular(15)),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: [
// Text(
// "15:20 —",
// style: TextStyle(
// fontSize: 20, fontWeight: FontWeight.w500),
// ),
// Text("  06:45",
// style: TextStyle(
// fontSize: 20, fontWeight: FontWeight.w500))
// ],
// ),
// Text("₹ 1,599",
// style:
// TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
// ],
// ),
// Text(
// "45  Seats are available",
// style: TextStyle(fontSize: 11, color: Colors.green),
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// children: [
// Text("Bus Type :",
// style:
// TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
// Container(
// padding: EdgeInsets.all(5),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: Color.fromARGB(255, 248, 232, 233),
// ),
// child: Text(" Local ",
// style: TextStyle(
// fontSize: 18, fontWeight: FontWeight.w500)),
// )
// ],
// ),
// Row(
// children: [
// Text(
// "Bus Name : Gujarat bus",
// style: TextStyle(fontSize: 13),
// )
// ],
// ),
// SizedBox(
// height: 20,
// ),
// Container(
// padding: EdgeInsets.all(5),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: Color.fromARGB(255, 248, 232, 233),
// ),
// child: Center(
// child: Text(
// "Return trip redDeal : Min 10% off on return ticket",
// ),
// ),
// )
// ],
// ),
// ));