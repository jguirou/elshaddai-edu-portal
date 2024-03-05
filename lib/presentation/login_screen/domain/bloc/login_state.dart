part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool onLoginClicked;
  final String email;
  final String password;
  final String loginStatus;

  const LoginState({
    this.isLoading = false,
    this.onLoginClicked = false,
    this.email = '',
    this.password = '',
    this.loginStatus = '',
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isLoading, onLoginClicked, email, password, loginStatus];

  LoginState copyWith({
    bool? isLoading,
    bool? onLoginClicked,
    String? email,
    String? password,
    String? loginStatus,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      onLoginClicked: onLoginClicked ?? this.onLoginClicked,
      email: email ?? this.email,
      password: password ?? this.password,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }
}
