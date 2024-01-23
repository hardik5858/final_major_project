import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Admin_Add_Bus_Data extends StatefulWidget {
  const Admin_Add_Bus_Data({super.key});

  @override
  State<Admin_Add_Bus_Data> createState() => _Admin_Add_Bus_DataState();
}

class _Admin_Add_Bus_DataState extends State<Admin_Add_Bus_Data> {
  TextEditingController _add_form=TextEditingController();
  TextEditingController _add_to=TextEditingController();
  TextEditingController _add_start=TextEditingController();
  TextEditingController _add_end=TextEditingController();
  TextEditingController _add_price=TextEditingController();
  TextEditingController _add_sits=TextEditingController();

  final _formkey=GlobalKey<FormState>();
  List<String> bus_types=["LOCAL","EXPRESS","SLEEPER COACH","VOLVO"];
  String selectedValue="Local";

  List<String> cityName=['ahmedabad','amreli','anand','aravalli','banaskantha','bharuch','bhavnagar','botad','chhota udaipur','dahod','dang','devbhumi dwarka','gandhinagar','gir somnath','jamnagar','kheda','kutch','mahisagar','mehsana','morbi','narmada','navsari','panchmahal','patan','porbandar','rajkot','sabarkantha','surat','surendranagar','tapi','vadodara','valsad'];

  valid(String value){
    String retval="" ;
    for(int i=0;i<cityName.length;i++){
      String name=cityName[i].toString();
      if(value!=name){
        retval="Your City Name $value Is Invalid";
      }else{
        return null;
      }
    }
    return retval;
  }

  bool _error_value=false;
  Add_Data(){
    if(_formkey.currentState!.validate()){
      setState(() {
        _error_value=false;
      });
    }else{
      setState(() {
        _error_value=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(title: Text("Add Information For Bus "),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5,right: 5,top: 50,bottom: 20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 233, 200),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 2
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bus Start Location",style: TextStyle(fontSize: 15,color: Colors.black),),
                      SizedBox(height: 8,),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white
                          ),
                          child: TextFormField(
                            controller: _add_form,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              borderSide:BorderSide(
                                width: 1,
                                color: Colors.black
                              )
                              ),
                              prefixIcon: Icon(Icons.location_searching,color: Colors.green,),
                              labelText: "From",
                              hintText: "Your Location",
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "This Field is Empty";
                              }
                              var re=valid(value.toString());
                              if(re!=null){
                                return re;
                              }
                              return null;
                            },
                            onTap: (){
                              if(_error_value){
                                setState(() {
                                  _formkey.currentState?.reset();
                                  _error_value=false;
                                });
                              }
                            },
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Bus End Location",style: TextStyle(fontSize: 15,color: Colors.black),),
                      SizedBox(height: 8,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white
                        ),
                        child: TextFormField(
                          controller: _add_to,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.yellow
                                  )
                              ),
                              prefixIcon: Icon(Icons.location_on,color: Colors.red,),
                              labelText: "To",
                              hintText: "Destination"
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "This Field is Empty";
                            }

                            if (_add_form.text==_add_to.text){
                              return "Same City Name Not Allow";
                            }

                            var re=valid(value.toString());
                            if(re!=null){
                              return re;
                            }
                            return null;
                          },
                          onTap: (){
                            if(_error_value){
                              setState(() {
                                _formkey.currentState?.reset();
                                _error_value=false;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Bus Start Time",style: TextStyle(fontSize: 15,color: Colors.black),),
                      SizedBox(height: 8,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          controller: _add_start,
                          decoration:InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black
                                  )
                              ),
                              prefixIcon: Icon(Icons.access_time_outlined,color: Colors.blue,),
                              labelText:"Start Time",
                              hintText: "Start time"
                          ),
                          onTap: ()async{
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime:TimeOfDay.now(),
                            );
                            if(picked != null){
                              setState(() {
                                _add_start.text= picked.format(context);
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Bus End Location",style: TextStyle(fontSize: 15,color: Colors.black),),
                      SizedBox(height: 8,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.none,
                          controller: _add_end,
                          decoration:InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black
                                  )
                              ),
                              prefixIcon: Icon(Icons.av_timer,color: Colors.blue,),
                              labelText:"End Time",
                              hintText: "End time"
                          ),
                          onTap: ()async{
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime:TimeOfDay.now(),
                            );
                            if(picked != null){
                              setState(() {
                                _add_end.text= picked.format(context);
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Bus Type",style: TextStyle(fontSize: 15,color: Colors.black),),
                      SizedBox(height: 8,),
                      SizedBox(
                        width: 240,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 3,color: Colors.white)
                            ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(width: 2,color: Colors.black)
                            // )
                          ),
                            items: bus_types.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                  child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue){
                              setState(() {
                                selectedValue=newValue!;
                              });
                            }
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(children: [
                        Text("Bus Price",style: TextStyle(fontSize: 15,color: Colors.black)),
                        SizedBox(
                          width:MediaQuery.of(context).size.width * 0.4 ,
                        ),
                        Text("Bus Sit",style: TextStyle(fontSize: 15,color: Colors.black)),
                      ],),
                      SizedBox(height: 8,),
                      Row(children: [
                        Container(
                          width:MediaQuery.of(context).size.width*0.4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: TextFormField(
                            controller: _add_price,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(width: 1,color: Colors.blue)
                              ),
                              prefixIcon: Icon(Icons.currency_rupee,color: Colors.blue,),
                              // labelText:"End Time",
                              hintText: "Price"
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Filed is Empty";
                              }
                              return null;
                            },
                            onTap: (){
                              if(_error_value){
                                setState(() {
                                  _formkey.currentState?.reset();
                                  _error_value=false;
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width:MediaQuery.of(context).size.width * 0.4/3
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: TextFormField(
                            controller: _add_sits,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(width: 1,color: Colors.blue)
                              ),
                                hintText: "Sit"
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return  "Filed is Empty";
                              }
                              if(value as int > 45){
                                return "sit valid only 45 sit";
                              }
                              return null;
                            },
                          ),
                        )
                      ],),
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            elevation:5,
                            color:Color.fromARGB(255, 201, 222, 193) ,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              splashColor: Colors.amber,
                              onTap: (){
                              },
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width: 180,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text("Add Data",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
