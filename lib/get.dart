import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class getinfo extends StatefulWidget {
  getinfo({Key? key}) : super(key: key);

  @override
  State<getinfo> createState() => _getinfoState();
}

class _getinfoState extends State<getinfo> {
  getdata()async{
   var result =  await FirebaseFirestore.instance.collection("students").get();
   return result;
  }
  String updatename = "";
  updatedata(id,value)async{
    await FirebaseFirestore.instance.collection("students").doc(id).update({
      'name': value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
        future: getdata(),
        builder: (context,dynamic snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                return Card(
                  margin:EdgeInsets.all(8),
                  child:ListTile(
                    leading: GestureDetector(
                      onTap: (){
                        Get.defaultDialog(
                          content: TextField(
                            onChanged: (value) {
                              setState(() {
                                updatename = value;
                              });
                            },
                          ),
                          actions: [ElevatedButton(onPressed:(){
                            updatedata(snapshot.data.docs[index].id,updatename);
                            setState(() {
                            });
                          } , child: Text("update name"))]
                        );
                      },
                      child: Icon(Icons.check_circle)),
                    title:Text("${snapshot.data.docs[index]['name']}")) ,
                    
                  );
              });
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        })
    );
  }
}