import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import '../widgets/post_card.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset('assets/images/ic_instagram.svg',color: primaryColor,height: 32,),
        actions: [
          IconButton(icon: const Icon(Icons.messenger_outline_outlined),onPressed: (){},)
        ],
      ),
      body: PostCard(),
    );
  }
}
