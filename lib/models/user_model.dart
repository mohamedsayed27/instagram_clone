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
}