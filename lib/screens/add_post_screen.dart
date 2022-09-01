import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methodes.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
  }

  bool isLoading = false;
  Uint8List? file;
  TextEditingController descriptionController = TextEditingController();

  void postImage({
    required String uId,
    required String userName,
    required String profileImage,
  }) async{
    try{
      setState(() {
        isLoading = true;
      });
      String res = await FirestoreMethods().uploadPost(discribtion: descriptionController.text, file: file!, uId: uId, userName: userName, profileImage: profileImage);
      if(res == 'Success'){
        setState(() {
          isLoading = false;
          descriptionController.text='';
          file = null;
        });
        showSnackBar(content: 'Posted', context: context);

      }else{
        showSnackBar(content: res, context: context);
      }
    }catch(e){
      showSnackBar(content: e.toString(), context: context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  this.file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  this.file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void removePostPhotoAndPostDescription(){
    setState(() {
      descriptionController.text = '';
      file = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return file == null
        ? Center(
            child: IconButton(
              onPressed: () {
                _selectImage(context);
              },
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
              title: const Text('Add Post'),
              actions: [
                TextButton(
                    onPressed: () {
                      postImage(uId: user.userId!, userName: user.name!, profileImage: user.image!);
                    },
                    child: const Text(
                      'POST',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(isLoading ==true) const Padding(
                    padding:  EdgeInsets.only(top: 8,bottom: 8),
                    child:  LinearProgressIndicator(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.image!),
                        radius: 40,
                      ),
                      SizedBox.fromSize(
                        size: Size(10, 0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 10),
                        child: Text(user.name!),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: AspectRatio(
                            aspectRatio: 478 / 451,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: MemoryImage(file!),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write your caption ....',
                        ),
                        maxLines: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
