part of 'editAccount_bloc.dart';

class EditAccountEvent extends Equatable{
  const EditAccountEvent();

  @override
  List<Object> get props => [];
}

class ChangeProfilePictureEvent extends EditAccountEvent{
  final UserProfile userProfile;
  const ChangeProfilePictureEvent(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class SubmitUsernameEvent extends EditAccountEvent{
  final UserProfile userProfile;
  const SubmitUsernameEvent(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class ChangeUsernameEvent extends EditAccountEvent{
  final String username;
  const ChangeUsernameEvent(this.username);

  @override
  List<Object> get props => [username];
}

class SubmitPasswordEvent extends EditAccountEvent{}

class ChangeCurrentPasswordEvent extends EditAccountEvent{
  final String password;
  const ChangeCurrentPasswordEvent(this.password);

  @override
  List<Object> get props => [password];
}

class ChangeNewPasswordEvent extends EditAccountEvent{
  final String password;
  const ChangeNewPasswordEvent(this.password);

  @override
  List<Object> get props => [password];
}


