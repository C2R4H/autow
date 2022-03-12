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

    String username = "";
    bool usernameValidate = false;
    String currentPassword = "";
    bool currentPasswordValidate = false;
    String newPassword = "";
    bool newPasswordValidate = false;


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
      } else {
        emit(EditAccountStateError("No picture choosed"));
      }
    });

    on<SubmitUsernameEvent>((event, emit) async {
      if (usernameValidate) {
        emit(EditAccountStateLoading());
        if (await _firestoreDatabaseMethods.doesNameAlreadyExist(username)) {
          await _firestoreDatabaseMethods.uploadUsername(
              username, event.userProfile.uid);
          await _authMethods.updateAuthUsername(username);
          emit(EditAccountStateUsernameSend());
        } else {
          emit(EditAccountStateError('This username already exists'));
        }
      } else {
        emit(EditAccountStateError('Error'));
      }
    });

    on<ChangeUsernameEvent>((event, emit) async {
      emit(EditAccountStateUsernameCopyWith(event.username));
      RegExp regexp =
          RegExp("^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]\$");
      if (regexp.hasMatch(event.username)) {
        emit(EditAccountStateUsernameValidate());
        username = event.username;
        usernameValidate = true;
      } else {
        usernameValidate = false;
      }
    });

    on<SubmitPasswordEvent>((event, emit) async {
      if(currentPasswordValidate && newPasswordValidate){
        emit(EditAccountStateLoading());
        await _authMethods.updatePassword(currentPassword, newPassword).then((e){
          print(e);
          if(e=='success'){
            emit(EditAccountStatePasswordSend());
          }else{
            emit(EditAccountStateError('Failed to change password'));
          }
        });
      }
    });

    on<ChangeCurrentPasswordEvent>((event, emit) async {
      emit(EditAccountStateCurrentPasswordCopyWith(event.password));
      RegExp regexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
      if (regexp.hasMatch(event.password)) {
        emit(EditAccountStateCurrentPasswordValidate());
        currentPassword = event.password;
        currentPasswordValidate = true;
        if(newPasswordValidate){
          emit(EditAccountStateCurrentPasswordAndNewPasswordValidate());
        }
      } else {
        currentPasswordValidate = false;
      }
    });

    on<ChangeNewPasswordEvent>((event, emit) async {
      emit(EditAccountStateNewPasswordCopyWith(event.password));
      RegExp regexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
      if (regexp.hasMatch(event.password)) {
        emit(EditAccountStateNewPasswordValidate());
        newPassword = event.password;
        newPasswordValidate = true;
        if(currentPasswordValidate){
          emit(EditAccountStateCurrentPasswordAndNewPasswordValidate());
        }
      } else {
        newPasswordValidate = false;
      }
    });
  }
}
