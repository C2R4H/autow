import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageMethods{
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadUserProfilePicture(imageFile,userProfile) async {
    String success = "";

    try{
    Reference reference = storage.ref('profilePictures/').child('${userProfile.username}.jpg');
    if(userProfile.profileImage!=""){
      await reference.delete();
      await reference.putFile(imageFile).whenComplete(() async {
        success = await reference.getDownloadURL();
      });
    }else{
      await reference.putFile(imageFile).whenComplete(() async {
        success = await reference.getDownloadURL();
      });
    }
    }catch(e){
      print(e.toString());
    }
    return success;
  }

}
