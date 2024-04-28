import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:llm_stethoscope/home.dart';

class MyEmailVerify extends StatefulWidget {
  const MyEmailVerify({Key? key}) : super(key: key);

  @override
  State<MyEmailVerify> createState() => _MyEmailVerifyState();
}

class _MyEmailVerifyState extends State<MyEmailVerify> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  EmailOTP myAuth = EmailOTP();

  bool isOTPSent = false;

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
                  controller: emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email Required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  myAuth.setConfig(
                    appEmail: "myapp@llmstethoscope.com",
                    appName: "LLM_Stethoscope",
                    userEmail: emailController.text,
                    otpLength: 6,
                    otpType: OTPType.digitsOnly,
                  );
                  if (await myAuth.sendOTP()) {
                    setState(() {
                      isOTPSent = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("OTP has been sent"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("OOPS! OTP Sending Failed!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text('Send OTP'),
              ),
              if (isOTPSent) ...[
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: otpController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'OTP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'OTP Required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (otpController.text.isNotEmpty) {
                      if (await myAuth.verifyOTP(otp: otpController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('OTP is verified'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHome()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid OTP'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter OTP'),
                        ),
                      );
                    }
                  },
                  child: Text('Verify'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
