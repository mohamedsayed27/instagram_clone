import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? discribtion;
  String? uId;
  String? userName;
  String? postId;
  String? datePublished;
  String? postUrl;
  String? profileImage;
  late final likes;

  PostModel({
    required this.discribtion,
    required this.uId,
    required this.userName,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    discribtion = json['discribtion'];
    uId = json['uId'];
    userName = json['userName'];
    postId = json['postId'];
    datePublished = json['datePublished'];
    postUrl = json['postUrl'];
    profileImage = json['profileImage'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'discribtion': discribtion,
      'uId': uId,
      'datePublished': datePublished,
      'postId': postId,
      'postUrl': postUrl,
      'profileImage': profileImage,
      'userName': userName,
      'likes': likes,

    };
  }

}
