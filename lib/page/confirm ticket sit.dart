import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_major_project/page/admin/add_bus_ticket_detail.dart';
import 'package:final_major_project/page/home_page.dart';
import 'package:final_major_project/page/select_ticket_sit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class Confirm_Ticket_sit extends StatefulWidget {
  selectTicket selectticket;
  Confirm_Ticket_sit({super.key,required this.selectticket});

  @override
  State<Confirm_Ticket_sit> createState() => _Confirm_Ticket_sitState(selectticket);
}

class _Confirm_Ticket_sitState extends State<Confirm_Ticket_sit> {
  selectTicket selectticket;
  _Confirm_Ticket_sitState(this.selectticket);
  final _formkey=GlobalKey<FormState>();
  final _formkey2=GlobalKey<FormState>();
  bool from2vaild=false;
  String _validationMessage = '';
  TextEditingController _passenger_name = TextEditingController();
  TextEditingController _card_number = TextEditingController();
  TextEditingController _card_expiration_date=TextEditingController();
  TextEditingController _card_cvv=TextEditingController();
  //space between tow widget
  double size=10;
  //font size data widget
  double fontsize=18.0;
  Color dataWidgetColor=Color.fromARGB(255, 248, 232, 233);

  Map<String, dynamic> busTimeTableData = {};
  userDataPaket userdatapaket=new userDataPaket();
  busDataPaket busdatapaket=new busDataPaket();

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello");
    Future.delayed(Duration.zero,(){
      fetchData();
      fetchUserData();
    });
  }
  Future<void> fetchData() async{
    try{
      print(selectticket.Bus_Ticket_Document);
      print("hello");
      var qs=await FirebaseFirestore.instance.collection("bus_Time_Table").doc(selectticket.Bus_Ticket_Document).get();
      setState(() {
        busTimeTableData=qs.data() as Map<String,dynamic>;
        busdatapaket.from=busTimeTableData['from'];
        busdatapaket.to=busTimeTableData['to'];
        busdatapaket.start_time=busTimeTableData['start_time'];
        busdatapaket.end_time=busTimeTableData['end_time'];
        busdatapaket.bus_name=busTimeTableData['bus_name'];
        busdatapaket.bus_type=busTimeTableData['bus_type'];

        isLoading = false;
      });
      print("Data secessfully fatch");
      print(busTimeTableData);
    }catch(e){
      print(e);
    }
  }
  Future<void> fetchUserData() async{
    var cureentUserAuth=FirebaseAuth.instance.currentUser;
      print(cureentUserAuth?.email);
      setState(() {
        userdatapaket.userEmailId=cureentUserAuth!.email!;
        userdatapaket.useruid=cureentUserAuth!.uid!;
      });
      print("data fetch ${userdatapaket.userEmailId}");
      print("data fetch ${userdatapaket.useruid}");
  }
  Future<void> saveTicketData() async{
    CollectionReference tickets=FirebaseFirestore.instance.collection("booked_tickets");

    await tickets.add({
      'passenger_name': _passenger_name.text,
      'user_email':userdatapaket.userEmailId,
      'from':busdatapaket.from,
      'to':busdatapaket.to,
      'start_time':busdatapaket.start_time,
      'end_time':busdatapaket.end_time,
      'bus_type':busdatapaket.bus_type,
      'bus_name':busdatapaket.bus_name,
      'selected_tickets':selectticket.current_bookedticket,
      'total_amount':totalAmount(),
      'card_number':_card_number.text,
      'card_expiration':_card_expiration_date.text,
      'card_cvv':_card_cvv.text,
      'bus_uid':selectticket.Bus_Ticket_Document,
      'user_uid':userdatapaket.useruid,
      'timestamp': FieldValue.serverTimestamp()
    });

    DocumentReference td=FirebaseFirestore.instance.collection("bus_Time_Table").doc(selectticket.Bus_Ticket_Document);

    await td.update({
      'booked':FieldValue.arrayUnion(selectticket.current_bookedticket)
    });

    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            content: Lottie.asset("animation/payment.json",width: 200,height: 200,repeat: false),
          );
        });

    // Wait for 3 seconds
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/user_homepage', (route) => false,
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Ticket Confirm",style: TextStyle(fontWeight: FontWeight.w500 ),),
      ),
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Name",style: TextStyle(fontSize: 15),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 248, 232, 233),
                      ),
                      child: TextFormField(
                        controller: _passenger_name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.person),
                          labelText: "Enter Passenger Name"
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "this Field is Empty";
                          }
                          return null;
                        },
                        onTap: (){
                          if(!_formkey.currentState!.validate()){
                            _formkey.currentState?.reset();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: size,),
                    Row(
                      children: [
                        Text("Email id: "),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: dataWidgetColor),
                          child: Text(userdatapaket.userEmailId ?? "not available",
                            style: TextStyle(fontSize: fontsize),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size,),
                    Row(
                      children: [
                        Text("From: "),
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: dataWidgetColor),
                          child: Text( busTimeTableData != null ? busTimeTableData['from'] : "not available",
                            style: TextStyle(fontSize: fontsize),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size,),
                    Row(
                      children: [
                        Text("To: "),
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:dataWidgetColor),
                          child: Text(busTimeTableData != null ? busTimeTableData['to'] : "not available",
                            style: TextStyle(fontSize: fontsize),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text("Start time: "),
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: dataWidgetColor),
                          child: Text(
                            busTimeTableData?['start_time'] ?? "not available",
                            style: TextStyle(fontSize: fontsize),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text("End Time: "),
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: dataWidgetColor),
                          child: Text(
                            busTimeTableData?['end_time'] ?? "not available",
                            style: TextStyle(fontSize: fontsize),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text("Bus Type: "),
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: dataWidgetColor),
                          child: Text(
                            busTimeTableData?['bus_type'] ?? "not available",
                            style: TextStyle(fontSize: fontsize),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text("Select Ticket: "),
                        for(int i=0;i<selectticket.current_bookedticket.length;i++)
                          Container(
                          padding:EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: dataWidgetColor),
                          child: Text(selectticket.current_bookedticket[i].toString(),
                            style: TextStyle(fontSize: fontsize),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Material(
                color: Colors.white,
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  splashColor: Colors.red,
                  onTap: (){
                    if(_formkey.currentState!.validate()) {
                      _card_number.clear();
                      _card_cvv.clear();
                      _card_expiration_date.clear();
                      showModalBottomSheet(
                        isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context){
                          return Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: Form(
                              key: _formkey2,
                              child: Container(
                                height:MediaQuery.of(context).size.height * .55,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 248, 232, 233),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30)
                                  )
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                        decoration: BoxDecoration(color:Color.fromARGB(255, 234, 248, 232),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.black
                                        )),
                                        child: Text("Total Amount: ${totalAmount()}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color.fromARGB(255, 248, 232, 233)),
                                        child: TextFormField(
                                          controller: _card_number,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10)),
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset("assets/image/credit.png",height:30,width: 20,color: Colors.grey,),
                                            ),
                                            labelText: "Enter Card Number",
                                          ),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            LengthLimitingTextInputFormatter(16),
                                            CardNumberFormatter(),
                                          ],
                                          textInputAction: TextInputAction.done,
                                          validator: (value){
                                            if(value!.isEmpty){
                                              return "This Field is Empty";
                                            }
                                            return null;
                                          },
                                          onTap: (){
                                            if(from2vaild){
                                              _formkey2.currentState!.reset();
                                              from2vaild=false;
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 180,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Color.fromARGB(255, 248, 232, 233)),
                                            child: TextFormField(
                                              controller: _card_expiration_date,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                                labelText: "Expiration MM/YY",
                                                hintText: "MM/YY"
                                              ),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(4),
                                                CardMonthInputFormatter(),
                                              ],
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "This Field is Empty";
                                                }
                                                return null;
                                              },
                                              onTap: (){
                                                if(from2vaild){
                                                  _formkey2.currentState!.reset();
                                                  from2vaild=false;
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 20,),
                                          Container(
                                            height: 60,
                                            width: 180,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Color.fromARGB(255, 248, 232, 233)),
                                            child: TextFormField(
                                              controller: _card_cvv,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(4)
                                              ],
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10)),
                                                  labelText: "CVV",
                                              ),
                                              validator: (value){
                                                if(_card_cvv.text.length <3){
                                                  return "4 Digit";
                                                }
                                                return null;
                                              },
                                              onTap: (){
                                                if(from2vaild){
                                                  _formkey2.currentState!.reset();
                                                  from2vaild=false;
                                                }
                                              },
                                            ),

                                          )
                                        ],
                                      ),
                                      SizedBox(height: 40,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Material(
                                            color: Color.fromARGB(
                                                255, 160, 225, 127),
                                            elevation:5,
                                            borderRadius: BorderRadius.circular(10),
                                            child: InkWell(
                                              splashColor: Colors.red,
                                              onTap: (){
                                                if(_formkey2.currentState!.validate()){
                                                  saveTicketData();
                                                  setState(() {
                                                    from2vaild=false;
                                                  });
                                                }else{
                                                  setState(() {
                                                    from2vaild=true;
                                                  });
                                                }
                                              },
                                              child:AnimatedContainer(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                duration: Duration(seconds: 2),
                                                width: MediaQuery.of(context).size.width*0.4,
                                                height: MediaQuery.of(context).size.height*0.07,
                                                alignment: Alignment.center,
                                                child: Text("Pay",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),

                              ),
                            ),
                          );

                        });
                    }
                  },
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    duration: Duration(seconds: 2),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    alignment: Alignment.center,
                    child: Text("Payment",style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int totalAmount(){
    return busTimeTableData['price'] * selectticket.current_bookedticket.length;
  }
}

class userDataPaket{
  String userEmailId="";
  String useruid="";
  String passenger_name="";

}
class busDataPaket{
  String from="";
  String to="";
  String start_time="";
  String end_time="";
  String bus_type="";
  String bus_name="";
}
class cardDataPaket{
  String card_number="";
  String expiration="";
  String card_cvv="";
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue previousValue,
      TextEditingValue nextValue,
      ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}