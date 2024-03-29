import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadPhotoToFirebase(String childName , Uint8List file,bool isPosts)async{
    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);
    if(isPosts){
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String url = await snap.ref.getDownloadURL();
    return url;
  }



  // trying by myself
  // Future<String> uploadImageToStorage(String childName,Uint8List file,bool isPosts)async{
  //   Reference reference = storage.ref().child(childName).child(auth.currentUser!.uid);
  //  UploadTask task =  reference.putData(file);
  //  TaskSnapshot taskSnapshot = await task;
  //  String url = await taskSnapshot.ref.getDownloadURL();
  //  return url;
  // }
}