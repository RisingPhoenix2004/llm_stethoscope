import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:llm_stethoscope/auth.dart';
import 'package:llm_stethoscope/home.dart';
import 'package:llm_stethoscope/register.dart';

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
                        TextFormField(decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText:'Email',
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
                        SizedBox(height: 30,),
                        TextFormField(
                          obscureText: true,
                            decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText:'Password',
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
                        TextButton(onPressed: (){}, child: Text('Forgot Password?',style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),)),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [Text(
                        //     'Login',style: TextStyle(
                        //       fontSize: 27,color: Colors.white,fontWeight:FontWeight.w700),
                        //   ),
                        //     CircleAvatar(
                        //       radius: 30,
                        //       backgroundColor: Color(0xff4c505b),
                        //       child: GestureDetector(
                        //         onTap:(){login(emailcontroller.text, passwordcontroller.text);},
                        //         child: IconButton(
                        //           color: Colors.white,
                        //           onPressed:(){
                        //             Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
                        //           },
                        //           icon: Icon(Icons.arrow_forward),
                        //         ),
                        //       ),
                        //     )
                        // ]),
                        GestureDetector(
                          onTap:(){login(emailcontroller.text, passwordcontroller.text);},
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Login",
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
                  children: [
                    Text("Don't have an account?",style: TextStyle(color: Colors.white),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyRegister()));
                    },
                        child: Text('Sign Up',style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      color: Colors.white
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
  void login(String email,String password) async {
    try {
      String email = emailcontroller.text;
      String password = passwordcontroller.text;

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        print("User logged in successfully !");
        Navigator.pushNamed(context, 'home');
      } else {
        print("User logging error");
      }
    } catch (e) {
      print("Error logging in: $e");
      // Handle error here, such as displaying an error message to the user
    }
  }

}
