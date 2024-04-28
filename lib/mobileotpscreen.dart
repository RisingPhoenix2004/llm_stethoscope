import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:llm_stethoscope/home.dart';
class MyMobileOTPScreen extends StatefulWidget {
  final String verificationID;
  const MyMobileOTPScreen({Key? key,required this.verificationID}) : super(key: key);

  @override
  State<MyMobileOTPScreen> createState() => _MyMobileOTPScreenState();
}

class _MyMobileOTPScreenState extends State<MyMobileOTPScreen> {
  TextEditingController otpcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithOTP()async{
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
           verificationId: widget.verificationID,
          smsCode: otpcontroller.text.trim()
      );
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if(user !=  null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHome()));
      }
      else{
      //   Sign In Failure
      }
    }
    catch(err)
    {
      print(err);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OTP Screen',
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
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
          ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                    controller: otpcontroller,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'OTP',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'OTP Required';
                      }
                      return null;
                    }
                ),
              ),
              SizedBox(height:30,),
              ElevatedButton(onPressed: signInWithOTP, child: Text('OTP'))
            ],
          ),
        ),
      ),
    );
  }
}
