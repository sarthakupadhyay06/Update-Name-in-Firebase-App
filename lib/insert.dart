import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class insert extends StatefulWidget {
  insert({Key? key}) : super(key: key);

  @override
  State<insert> createState() => _insertState();
}

class _insertState extends State<insert> {

  adddata(value,mail)async{
    await FirebaseFirestore.instance.collection("students").add({
      'name':value,
      'email':mail,
    });
  }
  String name="";
  String email="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value,) {
              setState(() {
                name =  value;
              });
            },
           decoration:InputDecoration(
            hintText:"Enter name"
             ),
          ),
         SizedBox(height: 40,),
          TextField(
            onChanged: (mail) {
              setState(() {
                email =  mail;
              });
            },
           decoration:InputDecoration(
            hintText:"Enter email id"
             ),),
              SizedBox(height: 40,),
         ElevatedButton(onPressed: (){
           adddata(name,email);
         }, child: Text("add data"))
      

      ],)
    );
  }
}