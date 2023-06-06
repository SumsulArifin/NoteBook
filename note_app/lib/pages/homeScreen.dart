import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/pages/createNoteScreen.dart';
import 'package:note_app/pages/editNoteScreen.dart';
import 'package:note_app/pages/singInScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.to(() => const LoginScreen());
              },
              child: const Icon(Icons.logout))
        ],
      ),
      body: Container(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("notes")
            .where("userId", isEqualTo: userId?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Data"));
          }
          if (snapshot != null && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var note = snapshot.data!.docs[index]['note'];
                // var note = snapshot.data!.docs[index]['note'];
                var docId = snapshot.data!.docs[index].id;
                return Card(
                  child: ListTile(
                    title: Text(note),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              print(docId);
                              Get.to(() => EditNoteScreen(),
                                  arguments: {"note": note, "docId": docId});
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: ()async{
                            
                          await  FirebaseFirestore.instance.collection("notes").doc(docId).delete();
                          },
                            child: Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateNoteScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
