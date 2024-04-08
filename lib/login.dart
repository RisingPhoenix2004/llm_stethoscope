import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:llm_stethoscope/auth.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController phonenumbercontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.png'),fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35,top:140),
                  child: Text('Welcome\nBack!',
                    style: TextStyle(color: Colors.white,fontSize: 33),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5,right: 35,left: 35),
                    child: Column(
                      children: [
                        TextField(decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText:'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))
                        )),
                        SizedBox(height: 30,),
                        TextField(
                          obscureText: true,
                            decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText:'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))
                        )),
                        SizedBox(height: 10,),
                        TextButton(onPressed: (){}, child: Text('Forgot Password?',style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(
                            'Login',style: TextStyle(
                              fontSize: 27,fontWeight:FontWeight.w700),
                          ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff4c505b),
                              child: GestureDetector(
                                onTap:login,
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: (){
                                    Navigator.pushNamed(context, 'home');
                                  },
                                  icon: Icon(Icons.arrow_forward),
                                ),
                              ),
                            )
                        ]),
                Row(
                  children: [
                    Text("Don't have an account?"),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context,"register");
                    },
                        child: Text('SignUp',style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18
                    ),
                    ))
                  ],
                )

                      ],
                    ),
                  ),
                )
              ],
            ),
    ),
    );
  }
  void login() async{

    String email = emailcontroller.text;
    String password = passwordcontroller.text;

    User? user = await _firebaseAuth.signUpWithEmailAndPassword(email, password);

    if(user!=null)
    {
      print("User Logged in successfully !");
      Navigator.pushNamed(context, 'home');
    }
    else{
      print("User Logging Error");
    }
  }
}
