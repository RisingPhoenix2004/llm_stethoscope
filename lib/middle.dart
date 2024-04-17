import 'package:flutter/material.dart';
import 'package:llm_stethoscope/emailverify.dart';
import 'package:llm_stethoscope/phoneverify.dart';

class MyMiddle extends StatefulWidget {
  const MyMiddle({super.key});

  @override
  State<MyMiddle> createState() => _MyMiddleState();
}

class _MyMiddleState extends State<MyMiddle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify Email',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEmailVerify()));
              } ,
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Verify through email",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPhoneVerify()));
              } ,
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Verify through Phone",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
