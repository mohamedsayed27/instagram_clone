import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadPhotoToFirebase(String childName , Uint8List file)async{
    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String url = await snap.ref.getDownloadURL();
    return url;
  }
}