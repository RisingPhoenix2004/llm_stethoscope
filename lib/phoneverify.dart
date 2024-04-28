import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llm_stethoscope/mobileotpscreen.dart';

class MyPhoneVerify extends StatefulWidget {
  const MyPhoneVerify({Key? key}) : super(key: key);

  @override
  State<MyPhoneVerify> createState() => _MyPhoneVerifyState();
}

class _MyPhoneVerifyState extends State<MyPhoneVerify> {
  TextEditingController mobilenumbercontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber() async {
    String phoneNumber = mobilenumbercontroller.text.trim();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-retrieval of verification code completed.
      },
      verificationFailed: (FirebaseAuthException ex) {
        // Verification failed.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Verification Failed"),
          backgroundColor: Colors.red,
        ));
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyMobileOTPScreen(verificationID: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout.
      },
      timeout: Duration(seconds: 120), // Set the verification code timeout to 120 seconds
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify Mobile',
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: mobilenumbercontroller,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mobile Number Required';
                    }
                    if (value.length < 10) {
                      return 'Enter Valid Mobile Number';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (mobilenumbercontroller.text.isNotEmpty) {
                    verifyPhoneNumber();
                  } else {
                    print("Enter Valid Mobile Number");
                  }
                },
                child: Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
