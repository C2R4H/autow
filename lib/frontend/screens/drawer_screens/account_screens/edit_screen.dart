part of '../account_screen.dart';

class edit_screen extends StatelessWidget {

  UserProfile userProfile;
  edit_screen(this.userProfile);

  FirebaseStorage storage = FirebaseStorage.instance;
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
          Reference reference = storage.ref().child('profilePictures/').child('${userProfile.username}.jpg');
          if (userProfile.profileImage != "") {
            await reference.delete();
          }
          UploadTask uploadTask = reference.putFile(imageFile);
          uploadTask.whenComplete(() async {
            String imageUrl = await reference.getDownloadURL();
            if (imageUrl != null) {
              await userProfile.uploadProfilePictureURL(imageUrl);
            }
          });
        } on FirebaseException catch (err) {
          print(err);
        }
      } catch (err) {
        print(err);
      }
    }

  @override
  Widget build(BuildContext context) {
    var screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        title: Text('Edit profile'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: ListView(
          children: [
            CircleAvatar(
                    backgroundColor: Color(0xff414141),
                    backgroundImage: userProfile.profileImage == ""
                        ? null
                        : NetworkImage(userProfile.profileImage!),
                    radius: screen_height / 12,
                    child: userProfile.profileImage == ""
                        ? Text(
                            userProfile.username![0],
                            style: TextStyle(
                              fontSize: screen_height / 15,
                              color: Colors.white,
                            ),
                          )
                        : null,
            ),
            TextButton(
              onPressed: () async {
                await _upload('gallery');
              },
              child: Container(
                child: Text('Upload image'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
