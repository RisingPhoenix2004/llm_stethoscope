import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llm_stethoscope/auth.dart';
import 'package:llm_stethoscope/emailverify.dart';
import 'package:llm_stethoscope/home.dart';

import 'login.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  //final FirebaseAuthService _firebaseAuth = FirebaseAuthService();
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController phonenumbercontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  String username = "",
      email = "",
      phonenumber = "",
      password = "";


  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 140),
              child: Text('Almost\nThere!',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5, right: 35, left: 35),
                child: Column(
                  children: [
                    TextFormField(
                        controller: usernamecontroller,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                        ),
                      validator: (value){
                          if(value!.isEmpty)
                            {
                              return 'Username is required';
                            }
                          return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))
                        ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Email required';
                        }
                        if(!value.contains("@"))
                          {
                            return 'Enter a valid email';
                          }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                        controller: phonenumbercontroller,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Phone Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))
                        ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Phone Number required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))
                        ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Password is required';
                        }
                        if(value.length<8)
                          {
                            return 'Password must contain atleast 8 characters';
                          }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(
                          'Sign Up', style: TextStyle(
                            fontSize: 27,color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff4c505b),
                            child: GestureDetector(
                              child: IconButton(
                                color: Colors.white,
                                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEmailVerify()));},
                                // onPressed: (){registerUser(email :emailcontroller.text, password: passwordcontroller.text, username: usernamecontroller.text, phone :phonenumbercontroller.text,);},
                                icon: Icon(Icons.arrow_forward),
                              ),
                            ),
                          )
                        ]),
                    Row(
                      children: [
                        Text("Already have an account?",style: TextStyle(
                          color: Colors.white
                        ),),
                        TextButton(onPressed: () {
                          Navigator.pushNamed(context, "login");
                        },
                            child: Text('Login', style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                              color: Colors.white,

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
    );;
  }

  void signUp() async {
    String username = usernamecontroller.text;
    String email = emailcontroller.text;
    String phone = phonenumbercontroller.text;
    String password = passwordcontroller.text;

    User? user = (await _firebaseAuth.signInWithEmailAndPassword(
        password : password, email: email)) as User?;

    if (user != null) {
      print("User is successfully created!");
      Navigator.pushNamed(context, 'home');
    }
    else {
      print("User is not created Error");
    }
  }
  Future<void> registerUser({required String email, required String password, required String username,
    required String phone}) async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await usersCollection.add({
        'username': username,
        'email': email,
        'uid': userCredential.user?.uid,
        'password': password,
        'phone': phone,
      });
      print(userCredential.user?.uid);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyHome()),
              (Route<dynamic> route) => false,
        );
      });
    }
   catch (e) {
  print(e);
  }
}

  Future<User?> signInWithEmailAndPassword(String username,String email,String phone,String password) async{

    try{
      UserCredential credential=await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,);
      await usersCollection.add({
        'username': username,
        'email': email,
        'phone' :phone,
        'password' :password,
      });
      return credential.user;
    }
    catch(err)
    {
      print("err");
    }
    return null;
  }
}
