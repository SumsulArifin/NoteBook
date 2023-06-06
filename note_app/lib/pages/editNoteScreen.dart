import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/pages/homeScreen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({Key? key}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Edit Note"
              // Get.arguments['note'].toString(),
              ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: noteController
                ..text = "${Get.arguments["note"].toString()}",
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("notes")
                      .doc(Get.arguments["docId"].toString())
                      .update(
                    {
                      "note": noteController.text.trim(),
                    },
                    
                  ).then((value) => {
                    Get.offAll(()=>HomeScreen())
                  });
                },
                child: Text("Update")),
          ],
        ),
      ),
    );
  }
}
