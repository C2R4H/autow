import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> uploadUser(userdata, uid) async {
    await firestore.collection("users").doc(uid).set(userdata).then((value) {
      print("user add");
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<bool> uploadUserProfilePictureURL(String url,uid) async {
    await firestore.collection("users").doc(uid).update({'picture': url}).whenComplete((){
      return true;
    });
    return false;
  }

  getUserByEmail(String email) async {
    return firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<String> getUserByName(String username) async {
    String email = '';
    await firestore
        .collection("users")
        .where("name", isEqualTo: username.toLowerCase())
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        email = doc['email'];
      });
    });
    return email; 
  }

  Future<bool> doesNameAlreadyExist(String name) async {
    final QuerySnapshot result = await firestore
        .collection('users')
        .where('name', isEqualTo: name)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 1) {
      return false;
    }
    return true;
  }
}
