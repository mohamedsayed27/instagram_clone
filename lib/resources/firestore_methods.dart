import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      {required String discribtion,
      required Uint8List file,
      required String uId,
      required String userName,
      required String profileImage}) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadPhotoToFirebase('posts', file, true);
      String postId = const Uuid().v1();
      PostModel postModel = PostModel(
          discribtion: discribtion,
          uId: uId,
          userName: userName,
          postId: postId,
          datePublished: DateTime.now().toString(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: []);
      fireStore.collection('posts').doc(postId).set(postModel.toJson());
      res = 'Success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }


  Future<void> postLikes({required String uId, required List likes, required String postId,bool isDoubleTab = true}) async{
    try{
      if(isDoubleTab && likes.contains(uId)){
        null;
      }else if(!isDoubleTab && likes.contains(uId)){
        await fireStore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayRemove([uId]),
        });
      }
      else{
        await fireStore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayUnion([uId]),
        });
      }
    }catch(error){
      print(error.toString());
    }
  }
}
