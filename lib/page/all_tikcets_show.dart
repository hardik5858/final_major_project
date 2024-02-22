import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_major_project/backend/variable_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class All_Tickets_Show_Admin extends StatefulWidget {
  const All_Tickets_Show_Admin({super.key});

  @override
  State<All_Tickets_Show_Admin> createState() => _All_Tickets_Show_AdminState();
}

class _All_Tickets_Show_AdminState extends State<All_Tickets_Show_Admin> {

  int total_tickets=0;
  int total_amount=0;
  bool isLoad=true;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOtherData();
  }

  Future<void> fetchOtherData() async{
    try{
      var qs=await FirebaseFirestore.instance.collection("booked_tickets").orderBy("store_date",descending: false).get();
      var documents=qs.docs;
      setState(() {
        total_tickets=qs.docs.length;
      });
      for(var i in documents){
        var data=i.data();
        setState(() {
          total_amount=data?['total_amount']+total_amount;
          isLoad=false;
        });
      }
    }catch(e){
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Tickets Detail"),),
      backgroundColor: Data_Variable.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isLoad ?SpinKitWave(color: Data_Variable.temlatecolor, type: SpinKitWaveType.center) :Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                padding: EdgeInsets.all(10),
                decoration:BoxDecoration(
                    color:Data_Variable.temlatecolor ,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text("Total Tickets: ${total_tickets}",style: TextStyle(fontSize: 16),),
              ),
              isLoad ? SpinKitWave(color: Data_Variable.temlatecolor, type: SpinKitWaveType.center)  : Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                padding: EdgeInsets.all(10),
                decoration:BoxDecoration(
                    color:Data_Variable.temlatecolor ,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text("Total Amount: ${total_amount}",style: TextStyle(fontSize: 16),),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("booked_tickets").orderBy("store_date",descending: false).snapshots(),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitWave(color: Data_Variable.temlatecolor, type: SpinKitWaveType.center) ,
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bus Information:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                              Text("From: ${documentData?['from']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                              Text("To: ${documentData?['to']}",style: TextStyle(fontSize:16),),
                              Text("Departure: ${documentData?['start_time']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                              Text("Arrival: ${documentData?['end_time']}",style: TextStyle(fontSize: 16),),
                              Text("Bus Type: ${documentData?['bus_type']}",style: TextStyle(fontSize:16)),
                              Text("Bus Name: ${documentData?['bus_name']}",style: TextStyle(fontSize:16)),
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
                              SizedBox(height: 5,),
                              Text("User Information:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                              Text("Passenger Name: ${documentData?['passenger_name']}",style: TextStyle(fontSize: 16),),
                              Text("User ID : ${documentData?['user_email']}",style: TextStyle(fontSize: 16),),
                              Text("Booked_date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime)}",style: TextStyle(fontSize:16)),
                              SizedBox(height: 5,),
                              Text("Payment Information:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                              Text("Card number: ${documentData?['card_number']}",style: TextStyle(fontSize: 16),),
                              Text("Total Amount: ${documentData?['total_amount']}",style: TextStyle(fontSize:16,))
                            ],
                          ),
                        ),
                      );
                    },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
