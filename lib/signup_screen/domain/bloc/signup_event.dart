part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class OnEmailFieldChanged extends SignupEvent {
  final String email;
  const OnEmailFieldChanged(this.email);
  @override
  // TODO: implement props
  List<Object?> get props => [email];

}
class OnPasswordFieldChanged extends SignupEvent {
  final String password;
  const OnPasswordFieldChanged(this.password);
  @override
  // TODO: implement props
  List<Object?> get props => [password];

}

class OnUsernameFieldChanged extends SignupEvent {
  final String username;
  const OnUsernameFieldChanged(this.username);
  @override
  // TODO: implement props
  List<Object?> get props => [username];

}

class OnSignUpClicked extends SignupEvent {

  const OnSignUpClicked();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
