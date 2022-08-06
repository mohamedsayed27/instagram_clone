import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/default_button.dart';
import 'package:instagram_clone/widgets/text_form_field.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';


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
  var formKey = GlobalKey<FormState>();
  Uint8List? image;
  bool isRegistering = false;
  AuthMethods authMethods = AuthMethods();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    Uint8List chosenImage = await pickImage(ImageSource.gallery);
    setState(() {
      image = chosenImage;
    });
  }

  void signUp() async{
    setState((){
      isRegistering = true;
    });
    if(image == null){
      String res = await AuthMethods().signUpUserWithoutImage(email: emailController.text,
          password: passwordController.text,
          bio: bioController.text,
          name: nameController.text,);

      setState((){
        isRegistering = false;
      });


      if(res == 'success'){
        showSnackBar(content: res, context: context);
      }else{
        showSnackBar(content: res, context: context);
      }
    } else{
      String res = await AuthMethods().signUpUser(email: emailController.text,
          password: passwordController.text,
          bio: bioController.text,
          name: nameController.text,
          file: image!);

      setState((){
        isRegistering = false;
      });


      if(res == 'success'){
        showSnackBar(content: res, context: context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResponsiveLayout(webScreen: WebScreenLayout(), mobileScreen: MobileScreenLayout())));
      }else{
        showSnackBar(content: res, context: context);
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
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
                        image != null
                            ? CircleAvatar(
                          radius: 70,
                          backgroundImage: MemoryImage(image!),
                        )
                            : const CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 90,
                          child: IconButton(
                              onPressed: () {
                                selectImage();
                              },
                              icon: const Icon(Icons.add_to_photos_rounded)),
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
                      validate: () {
                        if (nameController.text.isEmpty) {
                          return 'Please Enter your name';
                        }
                      },
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
                      validate: () {
                        if (bioController.text.isEmpty) {
                          return 'Please Enter your Bio';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    isRegistering ? const Center(child: CircularProgressIndicator(),) : SpecialButton(
                        bColor: blueColor,
                        tColor: primaryColor,
                        text: 'Register',
                        press: () async {
                          if (formKey.currentState!.validate()) {
                            signUp();
                          }
                        },
                        oLayColor: Colors.white60),
                    // const SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const[
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
              ),
            )),
      ),
    );
  }
}
