import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llm_stethoscope/auth.dart';
import 'package:llm_stethoscope/emailverify.dart';
import 'package:llm_stethoscope/home.dart';
import 'package:llm_stethoscope/middle.dart';

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
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                SizedBox(height: 100,),
                Text('Almost There!',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
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
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
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
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
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
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
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
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  // // onPressed: (){registerUser(email :emailcontroller.text, password: passwordcontroller.text, username: usernamecontroller.text, phone :phonenumbercontroller.text,);},
                  onTap:(){
                    String username = usernamecontroller.text;
                    String email = emailcontroller.text;
                    String phone = phonenumbercontroller.text;
                    String password = passwordcontroller.text;
          
                    if(username.isNotEmpty && email.isNotEmpty && phone.isNotEmpty && password.isNotEmpty )
                      {
                        print("0");
                        registerUser(email :emailcontroller.text, password: passwordcontroller.text, username: usernamecontroller.text, phone :phonenumbercontroller.text,);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMiddle()));
                      }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill all fields!'),));
                      }
                    },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              ],),
            ),
          ),
        ),
      ),
    );
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
