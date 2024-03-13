import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_major_project/backend/variable_data.dart';
import 'package:final_major_project/page/admin/admin_tourisum/admin_torisum_add_data.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Admin_Tourisum extends StatefulWidget {
  const Admin_Tourisum({super.key});

  @override
  State<Admin_Tourisum> createState() => _Admin_TourisumState();
}

class _Admin_TourisumState extends State<Admin_Tourisum> {
  bool isRefreshing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Data_Variable.admintourisum="Top Destination Data";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Data_Variable.backgroundColor,
      body:SingleChildScrollView(child: Tourisum_Top_Destination()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Tourisum_Top_Destination()));
        },
        child: Icon(Icons.add),

      ),
    );
  }
}

Widget Tourisum_Top_Destination(){
  return FutureBuilder(
      future: FirebaseFirestore.instance.collection("Tourisum_Data_Top_Destination").get(),
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
        if(!snapshot.hasData){
          return Center(
            child: Text("Data is Empty"),
          );
        }
        var documents=snapshot.data?.docs;
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: documents?.length,
            itemBuilder: (context,index){
            var documentData =documents?[index].data();
            List<dynamic>? allAddList = documentData?['all_add'];
            return Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Image:",style: TextStyle(fontSize: 16),),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.longestSide,
                      decoration: BoxDecoration(
                          color: Data_Variable.fonttransperent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1,
                            color: Colors.grey
                          )
                      ),
                      child: documentData?['image_url'] != null ?
                      ClipRRect(
                        borderRadius:BorderRadius.circular(10),
                        child: Image.network(documentData?['image_url'],
                          fit: BoxFit.fill,),
                      ): Center(child: Text("No Select Image")),
                    ),
                    Text("Place Name: ${Data_Variable.firstUpre(documentData?['place_name'] ?? "")}",style: TextStyle(fontSize: 16),),
                    Text("Place Where is Heare: ${Data_Variable.firstUpre(documentData?['place_where_heare'] ?? "")}",style: TextStyle(fontSize: 16),),
                    Text("Place Hiatorical Information: ${Data_Variable.firstUpre(documentData?['historical_information'] ?? "")}",style: TextStyle(fontSize: 16),),
                    Text("Information Of place:", style: TextStyle(fontSize: 16)),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey
                              )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: allAddList != null ? allAddList.map<Widget>((entry){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20,),
                                    Text(Data_Variable.firstUpre("Heading: "+entry['heading'] ?? ""),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                    Text(Data_Variable.firstUpre("Content: "+entry['content'] ?? ""),style: TextStyle(fontSize: 16)),
                                  ],
                                );
                              }).toList() : []
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: (){
                              String Document_id = snapshot.data!.docs[index].id;
                              FirebaseFirestore.instance.collection("Tourisum_Data_Top_Destination").doc(Document_id).delete();
                            },
                            icon:  Icon(
                              Icons.delete,
                              color: Colors.black54,
                            ),),
                        IconButton(
                            onPressed: (){
                              String documentId = snapshot.data!.docs[index].id;
                              Map<String, dynamic> documentData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                              TourismDataModel tourismDataModel = TourismDataModel(
                                documentId: documentId,
                                documentData: documentData,
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Tourisum_Top_Destination_Update(tourismDataModel: tourismDataModel)));
                            },
                            icon:Icon(
                              Icons.edit_note
                            ))
                      ],
                    )
                  ],
              ),
              ),
            );
            }
        );
      });
}

class TourismDataModel{
  String documentId;
  Map<String, dynamic> documentData;
  TourismDataModel({required this.documentId,required this.documentData});
}

// Widget Fair_And_Festival(){
//   return FutureBuilder(
//       future: FirebaseFirestore.instance.collection("Fair and Festival Data").get(),
//       builder: (context,snapshot){
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if(snapshot.hasError){
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         }
//         if(!snapshot.hasData){
//           return Center(
//             child: Text("Data is Empty"),
//           );
//         }
//         var documents=snapshot.data?.docs;
//         return ListView.builder(
//             shrinkWrap: false,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: documents?.length,
//             itemBuilder: (context,index){
//               var documentData =documents?[index].data();
//               List<dynamic>? allAddList = documentData?['all_add'];
//               return Card(
//                 elevation: 5,
//                 child: Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color:Color.fromARGB(255, 255, 255, 255),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Image:",style: TextStyle(fontSize: 16),),
//                     ],
//                   ),
//                 ),
//               );
//             }
//         );
//
//       }
//       );
// }