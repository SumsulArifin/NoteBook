// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/pages/singInScreen.dart';

import '../services/singUpservices.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController uNamecontroler = TextEditingController();
  TextEditingController uPhonecontroler = TextEditingController();
  TextEditingController uEmailcontroler = TextEditingController();
  TextEditingController uPasswordcontroler = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Sing Up"),
        // actions: [
        //   Icon(Icons.more_vert),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 250.0,
                child: Lottie.asset("assets/38435-register.json"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: uNamecontroler,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: uPhonecontroler,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Mobail Number",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: uEmailcontroler,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: uPasswordcontroler,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: Icon(Icons.visibility),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  var userName = uNamecontroler.text.trim();
                  var userPhone = uPhonecontroler.text.trim();
                  var userEmail = uEmailcontroler.text.trim();
                  var userPassword = uPasswordcontroler.text.trim();
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: userEmail, password: userPassword)
                      .then((value) => {singUpUser(
                      userName,
                      userPhone,
                      userEmail,
                      userPassword

                  )});
                },
                child: Text("Sing Up"),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                child: Container(
                  child: Card(child: Text("Already have an account SingUp ")),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
