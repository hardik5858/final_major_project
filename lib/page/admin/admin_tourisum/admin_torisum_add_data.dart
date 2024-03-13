import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_major_project/backend/variable_data.dart';
import 'package:final_major_project/page/admin/admin_tourisum/admin_tourisum.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Admin_Tourisum_Top_Destination extends StatefulWidget {
  const Admin_Tourisum_Top_Destination({super.key});
  @override
  State<Admin_Tourisum_Top_Destination> createState() => _Admin_Tourisum_Top_DestinationState();
}

class _Admin_Tourisum_Top_DestinationState extends State<Admin_Tourisum_Top_Destination> {
  final _formkey=GlobalKey<FormState>();
  final _formkey2=GlobalKey<FormState>();

  TextEditingController _add_palce_name=TextEditingController();
  TextEditingController _add_place_wehre_heare=TextEditingController();
  TextEditingController _add_historical_information=TextEditingController();
  TextEditingController _add_key_heading_about_place=TextEditingController();
  TextEditingController _add_about_place=TextEditingController();
  Map<String, String> _errors = {'place': '', 'place_wehre_heare': '','historical_information':'','about_place':'',};

    List<Entry> entries=[];
    bool _isUploading = false;
    XFile? _image;
  void _addEntry(){
    String heading=_add_key_heading_about_place.text;
    String content=_add_about_place.text;
    setState(() {
      entries.add(Entry(id: UniqueKey().toString(),heading: heading, content: content));
    });
    _add_key_heading_about_place.clear();
    _add_about_place.clear();
  }

  Future<void> _submitFrom() async {
    try{
      if (entries.isNotEmpty && _image != null) {
        setState(() {
          _isUploading=true;
        });
        var firestoreInstance = FirebaseFirestore.instance;
        var collectionReference = firestoreInstance.collection('Tourisum_Data_Top_Destination');

        // Convert entries list to a list of maps
        List<Map<String, String>> entriesData = entries.map((entry) {
          return {
            'heading': entry.heading,
            'content': entry.content,
          };
        }).toList();

        String imageUral=await uploadImageToFirebase(File(_image!.path));

        // Add data to Firestore
        await collectionReference.add({
          'place_name': _add_palce_name.text,
          'place_where_heare': _add_place_wehre_heare.text,
          'historical_information': _add_historical_information.text,
          'all_add': entriesData,
          'image_url':imageUral
        });

        // Clear entries list after adding to Firestore
        entries.clear();
        _add_palce_name.clear();
        _add_place_wehre_heare.clear();
        _add_historical_information.clear();
        setState(() {
          _image=null;
          _isUploading=false;
        });
      }
    }catch(e){
      print(e);
      setState(() {
        _isUploading=false;
      });
    }

  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image=image;
      });
    }
  }

  Future<String> uploadImageToFirebase(File imageFile) async{
    String imageName=basename(imageFile.path);
    Reference storageRefrence=FirebaseStorage.instance.ref().child('image/Torisum/$imageName');
    UploadTask uploadTask=storageRefrence.putFile(imageFile);
    await uploadTask.whenComplete(() => print("Image uploaded to Firebase'"));
    return await storageRefrence.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.yellow,Colors.orange,Colors.orangeAccent]
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tourism Top Destination"),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        // constraints: BoxConstraints(maxWidth: 400.0),
                        width: MediaQuery.of(context).size.longestSide,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1
                            )
                        ),
                        child: _image == null ? Center(child: Text("No Select Image")) : Image.file(File(_image!.path)),
                      ),
                      Positioned(
                        bottom: 10,
                          right: 10,
                          child: IconButton(
                            onPressed: (){
                              _pickImage(context);
                            },
                            icon: Icon(Icons.add_a_photo),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: _add_palce_name,
                    decoration: myBoxDecoration(labelText: "Place",hintText: "Enter Palce",error: _errors['place']),
                    validator: (value){
                      if(value!.isEmpty){
                        return "This Field is Empty";
                      }
                    },
                    onChanged: (value){
                      setState(() {
                        _errors['place']="";
                      });
                    },
                  ),
                  TextFormField(
                    controller: _add_place_wehre_heare,
                    decoration: myBoxDecoration(labelText: "Place where is heare",hintText: "Enter Place Information",error: _errors['place_wehre_heare']),
                    validator: (value){
                      if(value!.isEmpty){
                        return "This Field is Empty";
                      }
                    },
                    onChanged: (value){
                      setState(() {
                        _errors['place']="";
                      });
                    },
                  ),
                  TextFormField(
                    controller: _add_historical_information,
                    decoration: myBoxDecoration(labelText: "Place historical information",hintText: "Enter Information"),
                  ),
                  Form(
                    key: _formkey2,
                      child:Column(
                        children: [
                          TextFormField(
                            controller: _add_key_heading_about_place,
                            decoration: myBoxDecoration(labelText: "Heading About place information",hintText: "Enter heading"),
                            style: TextStyle(fontWeight: FontWeight.w700),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a heading';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _add_about_place,
                            decoration: myBoxDecoration(labelText: "About place information",hintText: "Enter Information",error: _errors['about_place']),
                            onChanged: (value){
                              setState(() {
                                _errors['about_place']="";
                              });
                            },
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return "This Field is Empty";
                              }
                              return null;
                            },
                            maxLines: 5,
                            minLines: 3,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FloatingActionButton(
                                onPressed: (){
                                  if(_formkey2.currentState!.validate()){
                                    _addEntry();
                                  }
                                },
                              child: Icon(Icons.add),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10,),
                          if(entries.isNotEmpty)
                            Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                            ),
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: entries.length,
                                  itemBuilder: (context, index) {
                                      // _show_data.text='Heading: ${entries[index].heading}\nContent: ${entries[index].content}';
                                    return RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context).style,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '${entries[index].heading}:',
                                              style: TextStyle(fontWeight: FontWeight.bold)
                                            ),
                                            TextSpan(
                                              text: '${entries[index].content}',
                                            )
                                          ]
                                        )
                                    );
                                  },
                                ),
                              ],
                            ),

                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                color: Color.fromARGB(255, 160, 225, 127),
                                elevation:5,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  splashColor: Colors.red,
                                  onTap: (){
                                    if(_formkey.currentState!.validate()) {
                                      _submitFrom();
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
                                    child: _isUploading ? CircularProgressIndicator() : Text("Add Data",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  InputDecoration myBoxDecoration({String? labelText,String? hintText,String? error,Icon? suffixIcon}){
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 2,
                color: Colors.black
            )
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 2
          )
        ),
      labelText: labelText ?? "", // Set default empty string if labelText is null
      hintText: hintText ?? "",
      errorText:"${error?.isEmpty ?? false ? error : ''}",
        suffixIcon: suffixIcon != null ? InkWell(child: suffixIcon,onTap: (){print("hello");},) : null,

    );
  }
}

class Entry{
  String id;
  String heading;
  String content;
  Entry({required this.id,required this.heading,required this.content});
}

class Admin_Tourisum_Top_Destination_Update extends StatefulWidget {
  TourismDataModel tourismDataModel;
  Admin_Tourisum_Top_Destination_Update({super.key,required this.tourismDataModel});
  @override
  State<Admin_Tourisum_Top_Destination_Update> createState() => _Admin_Tourisum_Top_Destination_UpdateState();
}

class _Admin_Tourisum_Top_Destination_UpdateState extends State<Admin_Tourisum_Top_Destination_Update> {
  final _formkey=GlobalKey<FormState>();
  final _formkey2=GlobalKey<FormState>();

  TextEditingController _add_palce_name=TextEditingController();
  TextEditingController _add_place_wehre_heare=TextEditingController();
  TextEditingController _add_historical_information=TextEditingController();
  TextEditingController _add_key_heading_about_place=TextEditingController();
  TextEditingController _add_about_place=TextEditingController();

  Map<String, String> _errors = {'place': '', 'place_wehre_heare': '','historical_information':'','about_place':'',};

  List<Entry> entries=[];
  bool _isUploading = false;
  XFile? _image;
  String image_url="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _add_palce_name.text=widget.tourismDataModel.documentData['place_name'] ?? "";
      _add_place_wehre_heare.text=widget.tourismDataModel.documentData['place_where_heare'] ?? "";
      _add_historical_information.text=widget.tourismDataModel.documentData['historical_information'] ?? "";
      List<dynamic>? allAddList =widget.tourismDataModel.documentData['all_add'] ?? "";
      allAddList != null ? allAddList.map((entry) {
        entries.add(Entry(id: UniqueKey().toString(),heading: entry['heading'] ?? "",content: entry['content'] ?? ""));
      }).toList():"";
      image_url=widget.tourismDataModel.documentData['image_url'] ?? "";
  }

  void _addEntry(){
    String heading=_add_key_heading_about_place.text;
    String content=_add_about_place.text;
    setState(() {
      entries.add(Entry(id: UniqueKey().toString(),heading: heading, content: content));
    });
    _add_key_heading_about_place.clear();
    _add_about_place.clear();
  }

  Future<void> _submitUpdateFrom(BuildContext context) async{
    try{
      if(entries.isNotEmpty && _image != null || image_url != null){
        print("hello3");
        setState(() {
          _isUploading=true;
        });
        var firebaseInstance=FirebaseFirestore.instance;
        var colllectionRefrence=firebaseInstance.collection('Tourisum_Data_Top_Destination').doc(widget.tourismDataModel.documentId);

        List<Map<String, String>> entriesData = entries.map((entry) {
          return {
            'heading': entry.heading,
            'content': entry.content,
          };
        }).toList();

        String imageUral= _image == null ? image_url : await uploadImageToFirebase(File(_image!.path));

        await colllectionRefrence.update({
          'place_name': _add_palce_name.text,
          'place_where_heare': _add_place_wehre_heare.text,
          'historical_information': _add_historical_information.text,
          'all_add': entriesData,
          'image_url':imageUral
        });

        setState(() {
          _isUploading=false;
        });
        Navigator.pop(context);
      }
    }catch(e){
      setState(() {
        _isUploading=false;
      });
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image=image;
      });
    }
  }
  Future<String> uploadImageToFirebase(File imageFile) async{
    String imageName=basename(imageFile.path);
    Reference storageRefrence=FirebaseStorage.instance.ref().child('image/Torisum/$imageName');
    UploadTask uploadTask=storageRefrence.putFile(imageFile);
    await uploadTask.whenComplete(() => print("Image uploaded to Firebase'"));
    return await storageRefrence.getDownloadURL();
  }
  bool isupdate=false;
  late int indexOuter;
  void updateHeading(int index,String newheading){
    setState(() {
      entries[index].heading=newheading;
    });
  }
  void updateContent(int index, String newContent){
    setState(() {
      entries[index].content=newContent;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Data"),),
      backgroundColor: Data_Variable.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.longestSide,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey
                        )
                      ),
                      child: _image == null ? image_url != null ? Image.network(image_url) :Center(child: Text("No Select Image")) : Image.file(File(_image!.path)),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          onPressed: (){
                            _pickImage(context);
                          },
                          icon: Icon(Icons.add_a_photo),
                        )
                    )
                  ],
                ),
                SizedBox(height: 30,),
                TextFormField(
                  controller: _add_palce_name,
                  decoration: myBoxDecoration(labelText: "Place",hintText: "Enter Palce",error: _errors['place']),
                  validator: (value){
                    if(value!.isEmpty){
                      return "This Field is Empty";
                    }
                  },
                  onChanged: (value){
                    setState(() {
                      _errors['place']="";
                    });
                  },
                ),
                TextFormField(
                  controller: _add_place_wehre_heare,
                  decoration: myBoxDecoration(labelText: "Place where is heare",hintText: "Enter Place Information",error: _errors['place_wehre_heare']),
                  validator: (value){
                    if(value!.isEmpty){
                      return "This Field is Empty";
                    }
                  },
                  onChanged: (value){
                    setState(() {
                      _errors['place']="";
                    });
                  },
                ),
                TextFormField(
                  controller: _add_historical_information,
                  decoration: myBoxDecoration(labelText: "Place historical information",hintText: "Enter Information"),
                ),
                Form(
                    key: _formkey2,
                    child:Column(
                      children: [
                        TextFormField(
                          controller: _add_key_heading_about_place,
                          decoration: myBoxDecoration(labelText: "Heading About place information",hintText: "Enter heading"),
                          style: TextStyle(fontWeight: FontWeight.w700),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a heading';
                            }
                            return null;
                          },
                          onChanged: (value){
                            if(isupdate){
                              updateHeading(indexOuter,value);
                            }
                          },
                        ),
                        TextFormField(
                          controller: _add_about_place,
                          keyboardType: TextInputType.multiline,
                          decoration: myBoxDecoration(labelText: "About place information",hintText: "Enter Information",error: _errors['about_place']),
                          onChanged: (value){
                            setState(() {
                              _errors['about_place']="";
                            });
                            if(isupdate){
                              updateContent(indexOuter,value);
                            }
                          },
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return "This Field is Empty";
                            }
                            return null;
                          },
                          maxLines: null,
                          // maxLines: 5,
                          minLines: 3,
                        ),
                        if(!isupdate)
                          Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            onPressed: (){
                              if(_formkey2.currentState!.validate()){
                                _addEntry();
                              }
                            },
                            child: Icon(Icons.add),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10,),
                        if(entries.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: entries.length,
                                  itemBuilder: (context, index) {
                                    // _show_data.text='Heading: ${entries[index].heading}\nContent: ${entries[index].content}';
                                    return GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isupdate=!isupdate;
                                          indexOuter=index;
                                        });
                                        _add_key_heading_about_place.text=entries[index].heading;
                                        _add_about_place.text=entries[index].content;
                                        if(!isupdate){
                                          _add_key_heading_about_place.clear();
                                          _add_about_place.clear();
                                        }
                                      },
                                      child: RichText(
                                          text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '${entries[index].heading}:',
                                                    style: TextStyle(fontWeight: FontWeight.bold)
                                                ),
                                                TextSpan(
                                                  text: '${entries[index].content}',
                                                )
                                              ]
                                          )
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                          ),

                      ],
                    )
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Color.fromARGB(255, 160, 225, 127),
                      elevation:5,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        splashColor: Colors.red,
                        onTap: (){
                          print("hello");
                          if(_formkey.currentState!.validate()) {
                            print("hello2");
                            _submitUpdateFrom(context);
                          }
                        },
                        child:AnimatedContainer(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          duration: Duration(seconds: 2),
                          width: MediaQuery.of(context).size.width*0.5,
                          height: MediaQuery.of(context).size.height*0.07,
                          alignment: Alignment.center,
                          child: _isUploading ? CircularProgressIndicator() : Text("Update Data",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  InputDecoration myBoxDecoration({String? labelText,String? hintText,String? error,bool contentPadding=false,Icon? suffixIcon}){
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 2,
              color: Colors.black
          )
      ),
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.green,
              width: 2
          )
      ),
      labelText: labelText ?? "", // Set default empty string if labelText is null
      hintText: hintText ?? "",
      errorText:"${error?.isEmpty ?? false ? error : ''}",
      suffixIcon: suffixIcon != null ? InkWell(child: suffixIcon,onTap: (){print("hello");},) : null,

    );
  }
}