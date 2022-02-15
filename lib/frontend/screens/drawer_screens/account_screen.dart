import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import '../../../midend/user_profile.dart';
import 'account_screens/edit_screen.dart';

class account_screen extends StatefulWidget {
  UserProfile? userProfile;
  account_screen({this.userProfile});
  @override
  account_screen_state createState() => account_screen_state();
}

class account_screen_state extends State<account_screen> {
  String username = "";
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  void initState() {
    username = widget.userProfile!.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _upload(String inputSource) async {
      final picker = ImagePicker();
      XFile? pickedImage;
      try {
        pickedImage = await picker.pickImage(
            source: inputSource == 'camera'
                ? ImageSource.camera
                : ImageSource.gallery,
            imageQuality: 50,
            maxWidth: 1920);

        final String fileName = path.basename(pickedImage!.path);
        File imageFile = File(pickedImage.path);

        try {
          Reference reference =
              storage.ref().child('profilePictures/').child('$username.jpg');
          if (widget.userProfile!.profileImage != "") {
            await reference.delete();
          }
          UploadTask uploadTask = reference.putFile(imageFile);
          uploadTask.whenComplete(() async {
            String imageUrl = await reference.getDownloadURL();
            if (imageUrl != null) {
              await widget.userProfile!.uploadProfilePictureURL(imageUrl);
            }
          });
        } on FirebaseException catch (err) {
          print(err);
        }
      } catch (err) {
        print(err);
      }
    }

    double screen_height = MediaQuery.of(context).size.height;
    double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Account Screen'),
        backgroundColor: Color(0xff121212).withOpacity(0.92),
        elevation: 0,
      ),
      body: 
           Container(
        padding: EdgeInsets.symmetric( horizontal: 15),
        color: Colors.black,
        child: RefreshIndicator(
          color: Color(0xffFF7171),
          backgroundColor: Color(0xff212121),
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            setState(() {});
          },
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff414141),
                    backgroundImage: widget.userProfile!.profileImage == ""
                        ? null
                        : NetworkImage(widget.userProfile!.profileImage!),
                    radius: screen_height / 12,
                    child: widget.userProfile!.profileImage == ""
                        ? Text(
                            username[0],
                            style: TextStyle(
                              fontSize: screen_height / 15,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screen_height / 30,
                        ),
                      ),
                      Text(
                        '10.01.2001',
                        style: TextStyle(
                          color: Color(0xff414141),
                          fontSize: screen_height / 35,
                        ),
                      ),
                      Text(
                        'Soroca',
                        style: TextStyle(
                          color: Color(0xff414141),
                          fontSize: screen_height / 35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => edit_screen()),
                      );
                },
                /*widget.userProfile!.isAuthenticated! ? () async {
                  setState(() {
                    isLoading = true;
                  });
                  await _upload('gallery');
                  setState(() {
                    isLoading = false;
                  });
                }: null,*/
                color: Color(0xff212121),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color: Color(0xff424242),
                    width: 2,
                  ),
                ),
                height: screen_height / 15,
                child: Container(
                  alignment: Alignment.center,
                  width: screen_width,
                  child: isLoading
                      ? CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white)
                      : Text(
                          'Edit profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
