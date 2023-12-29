part of 'signup_bloc.dart';

  class SignupState extends Equatable {
    final bool isLoading;
  final bool onSignUpClicked;
  final String email;
  final String password;
  const SignupState( {
    this.isLoading = false,
    this.onSignUpClicked = false,
     this.email = '',
     this.password ='',
});

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, onSignUpClicked, email, password];

    SignupState copyWith({
    bool? isLoading,
    bool? onSignUpClicked,
    String? email,
    String? password,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      onSignUpClicked: onSignUpClicked ?? this.onSignUpClicked,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}


