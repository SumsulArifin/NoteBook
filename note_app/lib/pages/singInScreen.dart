// ignore: file_names
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, file_names, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/pages/homeScreen.dart';
import 'package:note_app/pages/forgotPassword.dart';
import 'package:note_app/pages/singUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailContriller = TextEditingController();
  TextEditingController loginPasswordContriller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Log In"),
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
                height: 300.0,
                child: Lottie.asset("assets/38435-register.json"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginEmailContriller,
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
                  controller: loginPasswordContriller,
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
                  var loginEmail = loginEmailContriller.text.trim();
                  var loginpassword = loginPasswordContriller.text.trim();
                  try {
                    final User? firebaseUser = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: loginEmail, password: loginpassword))
                        .user;
                    if(firebaseUser!=null){
                      Get.to(()=>HomeScreen());
                    }
                    else{
                      print("Check Email & Password");
                    }
                  } on FirebaseAuthException catch (e) {
                    print("Error$e");
                  }
                },
                child: Text("Login"),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>ForgotEmailScreen());
                },
                child: Container(
                  child: Card(child: Text("Forget Password")),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SingUpScreen());
                },
                child: Container(
                  child: Card(child: Text("Don't have an account SingUp ")),
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
