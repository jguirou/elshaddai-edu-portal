part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class OnEmailFieldChanged extends LoginEvent {
  final String email;

  const OnEmailFieldChanged(this.email);

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class OnPasswordFieldChanged extends LoginEvent {
  final String password;

  const OnPasswordFieldChanged(this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [password];
}

class OnUsernameFieldChanged extends LoginEvent {
  final String username;

  const OnUsernameFieldChanged(this.username);

  @override
  // TODO: implement props
  List<Object?> get props => [username];
}

class OnLoginClicked extends LoginEvent {
  const OnLoginClicked();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnResetLoginStatus extends LoginEvent {
  const OnResetLoginStatus();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
