part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool onLoginClicked;
  final bool obscureText;

  final String loginStatus;

  const LoginState({
    this.isLoading = false,
    this.onLoginClicked = false,
    this.obscureText = true,
    this.loginStatus = '',
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isLoading, onLoginClicked, loginStatus, obscureText];

  LoginState copyWith({
    bool? isLoading,
    bool? onLoginClicked,
    bool? obscureText,
    String? loginStatus,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      onLoginClicked: onLoginClicked ?? this.onLoginClicked,
      obscureText: obscureText ?? this.obscureText,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }
}
