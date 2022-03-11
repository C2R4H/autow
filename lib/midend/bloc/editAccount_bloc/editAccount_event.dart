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

class ChangeUsernameEvent extends EditAccountEvent{
  final String username;
  const ChangeUsernameEvent(this.username);

  @override
  List<Object> get props => [username];
}

class ChangePasswordEvent extends EditAccountEvent{
  final String password;
  const ChangePasswordEvent(this.password);

  @override
  List<Object> get props => [password];
}

