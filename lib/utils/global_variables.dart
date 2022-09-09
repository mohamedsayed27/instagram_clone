import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/feeds_screen.dart';

import '../screens/add_post_screen.dart';

const webSizeScreen = 700;


const homeScreenItems = [
  FeedsScreen(),
  Center(child: Text('search')),
  AddPostScreen(),
  Center(child: Text('favorite')),
  Center(child: Text('profile')),
];