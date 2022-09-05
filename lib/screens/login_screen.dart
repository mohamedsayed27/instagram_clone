import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/register_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/default_button.dart';
import 'package:instagram_clone/widgets/text_form_field.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLogin = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void sinIn() async {
    setState(() {
      isLogin = true;
    });
    String res = await AuthMethods().signInUser(
        email: emailController.text, password: passwordController.text);

    if (res == 'success') {
      showSnackBar(content: 'Login successfully', context: context);
    } else {
      showSnackBar(content: res, context: context);
    }
    print(res);
    setState(() {
      isLogin = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //svgImage
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              //login textFormField
              DefaultTextFormField(
                controller: emailController,
                hintText: 'Write your email',
                keyboardType: TextInputType.emailAddress,
                isPassword: false,
                prefixIcon: const Icon(
                  Icons.email,
                  color: primaryColor,
                ),
                validate: () {
                  if (emailController.text.isEmpty) {
                    return 'Please Enter your mail';
                  }
                },
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
                validate: () {
                  if (passwordController.text.isEmpty) {
                    return 'Please Enter your password';
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              isLogin
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SpecialButton(
                      bColor: blueColor,
                      tColor: primaryColor,
                      text: 'Login',
                      press: () {
                        if (formKey.currentState!.validate()) {
                          sinIn();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ResponsiveLayout(webScreen: WebScreenLayout(), mobileScreen: MobileScreenLayout())));
                        }
                      },
                      oLayColor: Colors.white60),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('you don\'t have an account ..?  '),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
