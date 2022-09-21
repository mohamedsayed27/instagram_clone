import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<UserModel> getUserDetails()async{
    User currentUser = auth.currentUser!;
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnap(snap);
  }


  Future<String> signUpUser({
    required String email,
    required String password,
    required String bio,
    required String name,
    required Uint8List file,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty ||
          name.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty) {
        //User registering
        UserCredential credential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl =
        await StorageMethods().uploadPhotoToFirebase('profilePicks', file,false);
        await firestore.collection('users').doc(credential.user!.uid).set({
          'email': email,
          'name': name,
          'followers': [],
          'following': [],
          'bio': bio,
          'uId': credential.user!.uid,
          'photoUrl': photoUrl
        });
        res = 'success';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }


  Future<String> signUpUserWithoutImage({
    required String email,
    required String password,
    required String bio,
    required String name,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty ||
          name.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty) {
        //User registering
        UserCredential credential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserModel model = UserModel(
            email: email,
            name: name,
            followers: [],
            following: [],
            bio: bio,
            userId: credential.user!.uid,
            image: 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg');
        await
        firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(model.toJson());
        res = 'success';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }


  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String res = ' some error occurred';
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          res = 'Email already used. Go to login page.';
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          res = 'Wrong email/password combination.';
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          res = 'No user found with this email.';
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          res = 'User disabled.';
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          res = 'Too many requests to log into this account.';
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          res = 'Server error, please try again later.';
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          res = 'Email address is invalid.';
          break;
        default:
          res = 'Login failed. Please try again.';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
