import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note_app/pages/homeScreen.dart';
class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController noteController=TextEditingController();
  User? userId=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Note"),),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text("01"),
            Container(

              child: TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: InputDecoration(hintText: "Add Note"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: ()async{
              var note=noteController.text.trim();
              if(note !=null){
                try{
                await  FirebaseFirestore.instance.collection("notes").doc().set({
                    "createdAt":DateTime.now(),
                    "note":note,
                    "userId":userId?.uid,


                  }).then((value) => {
                  Get.offAll(()=>HomeScreen())
                });

                } catch(e){print("Error $e");}

              }

            }, child: Text("Add Note"))
          ],
        ),
      ),
    );
  }
}
