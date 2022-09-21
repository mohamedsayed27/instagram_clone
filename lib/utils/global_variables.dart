import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/feeds_screen.dart';
import '../screens/add_post_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

const webSizeScreen = 700;


var homeScreenItems = [
  const FeedsScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(child: Text('favorite')),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];