import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
   String? email;
   String? name;
   List? followers;
   List? following;
   String? bio;
   String? userId;
   String? image;

  UserModel(
      {required this.email,
        required this.name,
        required this.followers,
        required this.following,
        required this.bio,
        required this.userId,
        required this.image});

  UserModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    name = json['name'];
    followers = json['followers'];
    following = json['following'];
    bio = json['bio'];
    userId = json['uId'];
    image = json['photoUrl'];
  }

  Map<String, dynamic> toJson(){
    return{
      'email': email,
      'name': name,
      'followers': followers,
      'following': following,
      'bio': bio,
      'uId': userId,
      'photoUrl':image,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        email: snapshot['email'],
        name: snapshot['name'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        bio: snapshot['bio'],
        userId: snapshot['uId'],
        image: snapshot['photoUrl']);
  }
}