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
}
