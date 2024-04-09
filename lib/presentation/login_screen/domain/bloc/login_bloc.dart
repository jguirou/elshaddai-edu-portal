import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/repositories/admin_repository/admin_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<OnLoginClicked>(_onLoginClicked);
    on<OnEmailFieldChanged>(_onEmailFieldChanged);
    on<OnPasswordFieldChanged>(_onPasswordFieldChanged);
    on<OnUsernameFieldChanged>(_onUsernameFieldChanged);
    on<OnResetLoginStatus>(_onResetLoginStatus);
  }

  void _onEmailFieldChanged(OnEmailFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      email: event.email.toLowerCase(),
    ));
  }

  void _onPasswordFieldChanged(OnPasswordFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  void _onUsernameFieldChanged(OnUsernameFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      password: event.username,
    ));
  }

  void _onResetLoginStatus(OnResetLoginStatus event, Emitter emit) {
    emit(state.copyWith(
      loginStatus: '',
    ));
  }

  void _onLoginClicked(OnLoginClicked event, Emitter<LoginState> emit) async {
    await for (final event
        in AdminRepository().signIn(state.email, state.password)) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(
            isLoading: false, loginStatus: FirebaseAuthError.noError.name));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
          loginStatus: e,
        ));
      });
    }
  }
}
