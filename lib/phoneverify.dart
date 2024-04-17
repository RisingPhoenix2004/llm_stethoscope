import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:llm_stethoscope/mobileotpscreen.dart';
class MyPhoneVerify extends StatefulWidget {
  const MyPhoneVerify({super.key});

  @override
  State<MyPhoneVerify> createState() => _MyPhoneVerifyState();
}

class _MyPhoneVerifyState extends State<MyPhoneVerify> {
  TextEditingController mobilenumbercontroller = new TextEditingController();
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
      },
      codeSent: (String verificationID, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyMobileOTPScreen(verificationID: verificationID),
        ));
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        // Auto-retrieval timeout.
      },
      timeout: Duration(seconds: 60), // Set the verification code timeout
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
      body: Center(
        child: Column(
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
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Mobile Number Required';
                    }
                    if(value.length<10)
                      {
                        return 'Enter Valid Mobile Number';
                      }
                    return null;
                  }
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed:verifyPhoneNumber,
                child: Text('Verify'))
          ],
        ),
      ),
    );
  }
}
