import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_major_project/page/confirm%20ticket%20sit.dart';
import 'package:flutter/material.dart';

class SelectTicket extends StatefulWidget {
  String Bus_Ticket_Document;
  SelectTicket({super.key,required this.Bus_Ticket_Document});

  @override
  State<SelectTicket> createState() => _SelectTicketState(Bus_Ticket_Document: Bus_Ticket_Document);
}

class _SelectTicketState extends State<SelectTicket> {
  _SelectTicketState({required this.Bus_Ticket_Document});

  String Bus_Ticket_Document;

  Color selectColor=Color.fromARGB(255, 255, 0, 0);
  Color booked=Colors.grey;
  Color available=Color.fromARGB(255, 115, 227, 99);

  List<int> matchedIndexes=[];
  List<int> current_bookedticket=[];
  List<int> totalBookedTicket=[];

  bool isLoading = true;

  Map<String, dynamic> busTimeTableData = {};


  selectTicket selectticket =new selectTicket();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello 1");
    Future.delayed(Duration.zero, ()
    {
      fetchOtherData();
    });
  }
  Future<void> fetchOtherData() async {
    // Replace this with your additional data fetching logic
    print("hello 2");
    try{
      var qs=await FirebaseFirestore.instance.collection("bus_Time_Table").doc(Bus_Ticket_Document).get();
      var ticketData=qs.data() as Map<String,dynamic>;
      print(qs);
      print(ticketData);
      // await Future.delayed(Duration(seconds: 2));
      setState(() {
        busTimeTableData = qs.data() as Map<String, dynamic>;
        collectData(busTimeTableData);
        isLoading=false;
      });
    }catch(e){
      print("error $e ");
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Seats",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            SizedBox(height: 1,),
            Row(
                   children: [
                     Text("${busTimeTableData['from']} ",style: TextStyle(fontSize: 15,color: Colors.grey)),
                     Icon(
                       Icons.arrow_forward,
                       size: 20,
                       color: Colors.grey,
                     ),
                     Text(" ${busTimeTableData['to']}",style: TextStyle(fontSize: 15,color: Colors.grey)),
                   ],
                 )
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: isLoading ?
      Center(
        child: CircularProgressIndicator(),
      )
      :SingleChildScrollView(
        child: Column(
          children: [
            Container(
                  width: MediaQuery.of(context).size.longestSide,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  margin: EdgeInsets.only(top: 40,left: 20,right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            margin: EdgeInsets.only(right: 10,),
                            decoration: BoxDecoration(
                                color: available
                            ),
                          ),
                          Text("Available ${busTimeTableData['sit']-totalBookedTicket.length}")
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            margin: EdgeInsets.only(right: 10,bottom: 5),
                            decoration: BoxDecoration(
                                color: selectColor
                            ),
                          ),
                          Text("Selected"+"   "+"${current_bookedticket.length}")
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            margin: EdgeInsets.only(right: 10,bottom: 5),
                            decoration: BoxDecoration(
                                color: booked
                            ),
                          ),
                          Text("Booked"+"  "+"${totalBookedTicket.length}")
                        ],
                      )
                    ],
                  ),
                ),
            Container(
              height: MediaQuery.of(context).size.height* 0.7,
              width: MediaQuery.of(context).size.longestSide,
              padding: EdgeInsets.symmetric(horizontal:20,vertical: 30 ),
              margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  width: 2,
                                  color: Colors.grey
                              ),
                              boxShadow: [BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.red
                              )]
                          ),
                          child: Center(child: Image.asset("assets/image/steering.png",width: 30,height: 30,)
                          )
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("————2————",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 40,),
                      Text("———————3———————",style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height:10,),
                  Expanded(
                          child: GridView.builder(
                            itemCount: busTimeTableData['sit'],
                              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemBuilder: (context,index){
                                  return GestureDetector(
                                    onTap: (){
                                      select_tapped(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 2,
                                              color: Colors.grey
                                          ),
                                          boxShadow: [BoxShadow(
                                            blurRadius: 3,
                                            color: totalBookedTicket.contains(index) ? booked : matchedIndexes.contains(index) ? selectColor : available,
                                          )]
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset("assets/image/seat-selection.png",width: 30,height: 30,color: totalBookedTicket.contains(index) ? booked : matchedIndexes.contains(index) ? selectColor : Colors.green,),
                                            Text(index!=0? "$index": "C",
                                              style: TextStyle(fontSize: 10,color: Colors.black),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                              }
                          )
                      )
                ],
              ),
            ),
            SizedBox(height: 20,),
            if(current_bookedticket.length >0)
              Material(
                color: Color.fromARGB(255, 253, 217, 214),
                elevation:5,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  splashColor: Colors.red,
                  onTap: (){
                    selectticket.current_bookedticket=current_bookedticket;
                    selectticket.totalBookedTicket=totalBookedTicket;
                    selectticket.Bus_Ticket_Document=Bus_Ticket_Document;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Confirm_Ticket_sit(selectticket: selectticket,)));
                  },
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    duration: Duration(seconds: 500),
                    width: MediaQuery.of(context).size.width*0.5,
                    height: MediaQuery.of(context).size.height*0.07,
                    alignment: Alignment.center,
                    child:Text("Ticket Booked",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  void select_tapped(int index){
    if(!totalBookedTicket.contains(index) && index!=0){
      setState(() {
        if(matchedIndexes.contains(index)){
          matchedIndexes.remove(index);
          current_bookedticket.remove(index);
        }else{
          matchedIndexes.add(index);
          current_bookedticket.add(index);
        }
      });
    }
  }

  void collectData(var td){
    // total booked ticket data fatch
    try{
      if(td['booked']!=null){
        List<dynamic> arryData=td['booked'];
        List<int> fetchList=arryData.map((value) => value as int).toList();
        print("step 1 complet");
        setState(() {
          totalBookedTicket=fetchList;
        });
        print("step 2 complet");
      }else{
        setState(() {
          totalBookedTicket=[];
        });
      }
    }catch(e){
      print(e);
    }
    print("data ${td['booked']}");
    print("step 3 complet ${totalBookedTicket}");
  }
}
class selectTicket{
  List<int> current_bookedticket=[];
  List<int> totalBookedTicket=[];
  String Bus_Ticket_Document="";
}

