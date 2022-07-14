import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/default_button.dart';
import 'package:instagram_clone/widgets/text_form_feild.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              //
              //svgImage
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: primaryColor,
                height: 54,
              ),
              const SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        'https://techunwrapped.com/wp-content/uploads/2022/04/Anonymous-keeps-up-the-pressure-on-Russia.jpg'),
                  ),
                  Positioned(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_to_photos_rounded)),
                    bottom: -10,
                    left: 90,
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              //name textFormField
              DefaultTextFormField(
                controller: nameController,
                hintText: 'Write your name',
                keyboardType: TextInputType.text,
                isPassword: false,
                prefixIcon: const Icon(
                  Icons.person,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //email textFormField
              DefaultTextFormField(
                controller: emailController,
                hintText: 'Write your email',
                keyboardType: TextInputType.emailAddress,
                isPassword: false,
                prefixIcon: const Icon(
                  Icons.email,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //password textFormField
              DefaultTextFormField(
                controller: passwordController,
                hintText: 'Write your password',
                keyboardType: TextInputType.emailAddress,
                isPassword: true,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //bio textFormField
              DefaultTextFormField(
                controller: bioController,
                hintText: 'Write your bio',
                keyboardType: TextInputType.text,
                isPassword: false,
                prefixIcon: const Icon(
                  Icons.short_text,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SpecialButton(
                  bColor: blueColor,
                  tColor: primaryColor,
                  text: 'Register',
                  press: () {},
                  oLayColor: Colors.white60),
              // const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('you have an account ..?  '),
                  Text(
                    'Sign in',
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
