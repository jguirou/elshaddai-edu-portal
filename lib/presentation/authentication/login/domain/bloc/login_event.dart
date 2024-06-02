part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class OnLoginClicked extends LoginEvent {
  const OnLoginClicked(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class OnObscureTextClicked extends LoginEvent {
  const OnObscureTextClicked();

  @override
  List<Object?> get props => [];
}

class OnResetLoginStatus extends LoginEvent {
  const OnResetLoginStatus();

  @override
  List<Object?> get props => [];
}
