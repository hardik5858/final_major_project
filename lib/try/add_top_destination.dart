import 'package:final_major_project/backend/firestor_backend.dart';
import 'package:final_major_project/backend/variable_data.dart';
import 'package:final_major_project/page/admin/bus_ticket_data.dart';
import 'package:flutter/material.dart';

class Add_Top_Destination extends StatefulWidget {
  const Add_Top_Destination({super.key});

  @override
  State<Add_Top_Destination> createState() => _Add_Top_DestinationState();
}

class _Add_Top_DestinationState extends State<Add_Top_Destination> {
  TextEditingController _add_to=TextEditingController();
  TextEditingController _add_start=TextEditingController();
  TextEditingController _add_end=TextEditingController();
  TextEditingController _add_price=TextEditingController();
  TextEditingController _add_sits=TextEditingController();
  TextEditingController _add_bus_name=TextEditingController();
  final _formkey=GlobalKey<FormState>();

  bool charging_port=false;
  bool ac_bus=false;
  bool internate=false;
  bool cctv=false;
  bool reading_light=false;
  bool water_bottle=false;

  List<String> bus_types=["EXPRESS","SLEEPER COACH","VOLVO"];
  String selectedValue="";
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

  Add_Data()async{
    if(_formkey.currentState!.validate()){
      Store_Bus_Data_Top_Destination store_bus_data=new Store_Bus_Data_Top_Destination();
      store_bus_data.to=_add_to.text;
      store_bus_data.start_time=_add_start.text;
      store_bus_data.end_time=_add_end.text;
      store_bus_data.bus_name=_add_bus_name.text;
      store_bus_data.bus_type=selectedValue;
      store_bus_data.price=int.parse(_add_price.text);
      store_bus_data.sits=int.parse(_add_sits.text);
      store_bus_data.charging_port=charging_port;
      store_bus_data.ac_bus=ac_bus;
      store_bus_data.internate=internate;
      store_bus_data.cctv=cctv;
      store_bus_data.reading_light=reading_light;
      store_bus_data.water_bottle=water_bottle;

      bool reset=await setBusDetail3(store_bus_data);
      print("hello $reset");

      setState(() {
        if(reset==true){
          _add_to.clear();
          _add_start.clear();
          _add_end.clear();
          _add_price.clear();
          _add_sits.clear();
          _add_bus_name.clear();
          selectedValue=bus_types[0];
          charging_port=false;
          ac_bus=false;
          internate=false;
          cctv=false;
          reading_light=false;
          water_bottle=false;
        }
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
      backgroundColor: Data_Variable.backgroundColor,
      appBar: AppBar(title: Text("Top Destination Place"),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: _formkey,
                  child: Container(
                    margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 20),
                      padding:EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 248, 233, 200),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Enter Place",style: TextStyle(fontSize: 15,color: Colors.black),),
                        SizedBox(height: 8,),
                        Container(
                          height: 59,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white
                          ),
                          child: TextFormField(
                            controller: _add_to,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:BorderSide(
                                      width: 1,
                                      color: Colors.black
                                  )
                              ),
                              prefixIcon: Icon(Icons.location_searching,color: Colors.green,),
                              labelText: "Enter Pacle",
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
                        Text("Bus Start Time",style: TextStyle(fontSize: 15,color: Colors.black),),
                        SizedBox(height: 8,),
                        Container(
                          height: 59,
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
                          height: 59,
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
                        Text("Bus Name",style: TextStyle(fontSize: 15,color: Colors.black),),
                        SizedBox(height: 8,),
                        Container(
                          height: 59,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            controller: _add_bus_name,
                            decoration:InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.black
                                    )
                                ),
                                prefixIcon: Icon(Icons.directions_bus,color: Colors.blue,),
                                labelText:"Enter Name",
                                hintText: "Enter Bus Name"
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "This Field is Empty";
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
                        Text("Bus Type",style: TextStyle(fontSize: 15,color: Colors.black),),
                        SizedBox(height: 8,),
                        SizedBox(
                          height: 59,
                          width: 220,
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
                            height: 59,
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
                            height: 59,
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
                                // Convert the string to an integer
                                int intValue = int.tryParse(value) ?? 0;
                                if(intValue > 45){
                                  return "sit valid only 45 sit";
                                }
                                return null;
                              },
                            ),
                          )
                        ],),
                        SizedBox(height: 15,),
                        Text("Bus Facility",style: TextStyle(fontSize: 15,color: Colors.black),),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        activeColor: Data_Variable.buttoncolor,
                                        value: charging_port,
                                        onChanged:(value){
                                          setState(() {
                                            print(value);
                                            charging_port=value!;
                                          });
                                        }),
                                    SizedBox(width: 5,),
                                    Text("Bus Charging Port",style: TextStyle(fontSize: 15,color: Colors.black),),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        activeColor: Data_Variable.buttoncolor,
                                        value: ac_bus,
                                        onChanged:(value){
                                          setState(() {
                                            print(value);
                                            ac_bus=value!;
                                          });
                                        }),
                                    SizedBox(width: 5,),
                                    Text("Ac Bus",style: TextStyle(fontSize: 15,color: Colors.black),),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        activeColor: Data_Variable.buttoncolor,
                                        value: internate,
                                        onChanged:(value){
                                          setState(() {
                                            print(value);
                                            internate=value!;
                                          });
                                        }),
                                    SizedBox(width: 5,),
                                    Text("Wifi Internate",style: TextStyle(fontSize: 15,color: Colors.black),),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        activeColor: Data_Variable.buttoncolor,
                                        value: cctv,
                                        onChanged:(value){
                                          setState(() {
                                            print(value);
                                            cctv=value!;
                                          });
                                        }),
                                    SizedBox(width: 5,),
                                    Text("CCTV",style: TextStyle(fontSize: 15,color: Colors.black),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        activeColor: Data_Variable.buttoncolor,
                                        value: reading_light,
                                        onChanged:(value){
                                          setState(() {
                                            print(value);
                                            reading_light=value!;
                                          });
                                        }),
                                    SizedBox(width: 5,),
                                    Text("Reading Light",style: TextStyle(fontSize: 15,color: Colors.black),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        activeColor: Data_Variable.buttoncolor,
                                        value: water_bottle,
                                        onChanged:(value){
                                          setState(() {
                                            print(value);
                                            water_bottle=value!;
                                          });
                                        }),
                                    SizedBox(width: 5,),
                                    Text("Water Bottle",style: TextStyle(fontSize: 15,color: Colors.black),),

                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
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
                                  Add_Data();
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Add Data Successfully"),
                                  ));
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
                    )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
class Store_Bus_Data_Top_Destination{
  String to="";
  String start_time="";
  String end_time="";
  String bus_name="";
  String bus_type="";
  int price=0;
  int sits=0;
  bool charging_port=false;
  bool ac_bus=false;
  bool internate=false;
  bool cctv=false;
  bool reading_light=false;
  bool water_bottle=false;
}