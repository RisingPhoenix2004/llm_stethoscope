import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService{
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<User?> signUpWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential credential=await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,);
      return credential.user;
    }
    catch(err)
    {
      print("err");
    }
    return null;
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