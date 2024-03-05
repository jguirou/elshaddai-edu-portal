import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/repositories/admin_repository/admin_repository.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<OnSignUpClicked>(_onSignUpClicked);
    on<OnEmailFieldChanged>(_onEmailFieldChanged);
    on<OnPasswordFieldChanged>(_onPasswordFieldChanged);
    on<OnUsernameFieldChanged>(_onUsernameFieldChanged);
  }

  void _onEmailFieldChanged(OnEmailFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      email: event.email,
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

  void _onSignUpClicked(
      OnSignUpClicked event, Emitter<SignupState> emit) async {
    await for (final event
        in AdminRepository().signUp(state.email, state.password)) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(
          isLoading: false,
        ));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }
}
