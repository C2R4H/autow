part of 'editAccount_bloc.dart';

class EditAccountState extends Equatable{
  String? username;
  String? password;
  UserProfile? userProfile;

  @override
  List<Object?> get props => [username,password];
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
class EditAccountStatePasswordValidate extends EditAccountState{}
class EditAccountStatePasswordCopyWith extends EditAccountState{
  EditAccountStatePasswordCopyWith(password);

  @override
  List<Object?> get props => [password];
}


