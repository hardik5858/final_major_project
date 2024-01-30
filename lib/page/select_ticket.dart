import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Select_User_Ticket extends StatefulWidget {
  const Select_User_Ticket({super.key});

  @override
  State<Select_User_Ticket> createState() => _Select_User_TicketState();
}

class _Select_User_TicketState extends State<Select_User_Ticket> {
  Color selectColor=Colors.red;
  Color booked=Colors.grey;
  Color available=Colors.green;

  List<String> matchedIndexes=[];
  List<String> current_bookedticket=[];
  List<String> totalBookedTicket=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Seats",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            SizedBox(height: 4,),
            Row(
              children: [
                Text("From ",style: TextStyle(fontSize: 15,color: Colors.grey),),
                Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Colors.grey,
                ),
                Text(" To",style: TextStyle(fontSize: 15,color: Colors.grey),),
              ],
            )

          ],
        )),
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.longestSide,
              padding: EdgeInsets.symmetric(horizontal:20,vertical: 20 ),
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
                      Text("Available")
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
                      Text("Selected")
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
                      Text("Booked")
                    ],
                  ),
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
              child:Column(
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
                          child: Center(child: Image.asset("assets/image/steering.png",width: 30,height: 30,))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 15,),
                    Text("————2————",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 40,),
                      Text("———————3———————",style: TextStyle(fontWeight: FontWeight.bold))
                  ],),
                  SizedBox(height:10,),
                  Expanded(
                    child: GridView.builder(
                      itemCount: 42,
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context,index){
                              return Container(
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
                                          child:  Center(
                                            child: Column(
                                              children: <Widget>[
                                                  // if(index==0)
                                                  //   Text("C",style: TextStyle(fontSize: 30,color: Colors.black),),
                                                  //  if(index!=0)
                                                  //    Image.asset("assets/image/seat-selection.png",width: 30,height: 30,color: Colors.green,),
                                                  //   if(index!=0)
                                                  //     Text(/*index!=0? */"$index"/*: "C"*/,
                                                  //       style: TextStyle(fontSize: 10,color: Colors.black),),
                    
                                                    Image.asset("assets/image/seat-selection.png",width: 30,height: 30,color: Colors.green,),
                                                    Text(index!=0? "$index": "C",
                                                      style: TextStyle(fontSize: 10,color: Colors.black),),
                                              ],
                                            ),
                                          ),
                                );
                        }),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
