import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../backend/services/firebaseStorage_database.dart';
import '../../../backend/services/firestore_database.dart';
import '../../../backend/services/authentication.dart';
import '../../user_profile.dart';

part 'editAccount_event.dart';
part 'editAccount_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc() : super(EditAccountState()) {
    FirebaseStorageMethods _firebaseStorageMethods = FirebaseStorageMethods();
    FirestoreDatabaseMethods _firestoreDatabaseMethods =
        FirestoreDatabaseMethods();
    AuthMethods _authMethods = AuthMethods();

    on<ChangeProfilePictureEvent>((event, emit) async {
      emit(EditAccountStateChooseProfileImage(event.userProfile));
      emit(EditAccountStateLoading());
      final _picker = ImagePicker();
      XFile? pickedImage;
      pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 1920,
      );
      if (pickedImage != null) {
        File imageFile = File(pickedImage.path);
        emit(EditAccountStateChoosedImage());
        String url = await _firebaseStorageMethods.uploadUserProfilePicture(
            imageFile, event.userProfile);
        if (url != "") {
          _firestoreDatabaseMethods.uploadUserProfilePictureURL(
              url, event.userProfile.uid);
          _authMethods.auth.currentUser!.updatePhotoURL(url);
          event.userProfile.profileImage = url;
        }
      }else{
        emit(EditAccountStateError("No picture choosed"));
      }
    });
  }
}
