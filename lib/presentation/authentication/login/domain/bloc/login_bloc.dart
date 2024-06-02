import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/repositories/admin_repository/admin_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<OnLoginClicked>(_onLoginClicked);
    on<OnResetLoginStatus>(_onResetLoginStatus);
    on<OnObscureTextClicked>(_onObscureTextClicked);
  }

  void _onResetLoginStatus(OnResetLoginStatus event, Emitter emit) {
    emit(state.copyWith(
      loginStatus: '',
    ));
  }

  void _onObscureTextClicked(OnObscureTextClicked event, Emitter emit) {
    emit(state.copyWith(
      obscureText: !state.obscureText,
    ));
  }

  void _onLoginClicked(OnLoginClicked event, Emitter<LoginState> emit) async {
    await for (final event
        in AdminRepository().signIn(event.email, event.password)) {
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
