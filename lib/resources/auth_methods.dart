import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods{


  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password ,
    required String bio,
    required String name,
    required Uint8List file,
}) async{
    String res = 'Some error occurred';
    try{
      if(email.isNotEmpty || name.isNotEmpty || password.isNotEmpty || bio.isNotEmpty){
        //User registering
        UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
        String photoUrl = await StorageMethods().uploadPhotoToFirebase('profilePicks', file);
        await firestore.collection('users').doc(credential.user!.uid).set({
          'email' : email,
          'name' : name,
          'followers' : [],
          'following' : [],
          'bio' : bio,
          'uId' : credential.user!.uid,
          'photoUrl' : photoUrl
        });
      }
    }catch(error){
      res = error.toString();
    }
    return res;
  }
}