part of 'editAccount_bloc.dart';

class EditAccountState extends Equatable{
  String? username;
  String? currentPassword;
  String? newPassword;
  UserProfile? userProfile;

  @override
  List<Object?> get props => [username,currentPassword,newPassword];
}

class EditAccountStateLoading extends EditAccountState{}

class EditAccountStateChooseProfileImage extends EditAccountState{
  EditAccountStateChooseProfileImage(userProfile);

  @override
  List<Object?> get props => [userProfile];
}
class EditAccountStateChoosedImage extends EditAccountState{}
class EditAccountStateUploadImage extends EditAccountState{}

class EditAccountStateUsernameSend extends EditAccountState{}
class EditAccountStateUsernameValidate extends EditAccountState{}
class EditAccountStateUsernameCopyWith extends EditAccountState{
  EditAccountStateUsernameCopyWith(username);

  @override
  List<Object?> get props => [username];
}

class EditAccountStatePasswordSend extends EditAccountState{}
class EditAccountStateCurrentPasswordValidate extends EditAccountState{}
class EditAccountStateCurrentPasswordCopyWith extends EditAccountState{
  EditAccountStateCurrentPasswordCopyWith(currentPassword);

  @override
  List<Object?> get props => [currentPassword];
}

class EditAccountStateNewPasswordValidate extends EditAccountState{}
class EditAccountStateNewPasswordCopyWith extends EditAccountState{
  EditAccountStateNewPasswordCopyWith(newPassword);
}

class EditAccountStateCurrentPasswordAndNewPasswordValidate extends EditAccountState{}

class EditAccountStateError extends EditAccountState{
  final message;
  EditAccountStateError(this.message);
}
