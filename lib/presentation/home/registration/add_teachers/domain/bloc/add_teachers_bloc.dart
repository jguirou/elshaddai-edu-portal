import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:el_shaddai_edu_portal/domain/entities/teachers/teachers.dart';
import 'package:equatable/equatable.dart';

import 'package:firebase_database/firebase_database.dart';

import '../../../../../../domain/repositories/class_level_repository/class_level_repository.dart';
import '../../../../../../domain/repositories/teacher_repository/teacher_repository.dart';

part 'add_teachers_event.dart';

part 'add_teachers_state.dart';

class AddTeachersBloc extends Bloc<AddTeachersEvent, AddTeachersState> {
  AddTeachersBloc() : super(const AddTeachersState()) {
    on<OnFamilyNameFieldChanged>(_onFamilyNameFieldChanged);
    on<OnNameFieldChanged>(_onNameFieldChanged);
    on<OnAddClicked>(_onAddClicked);
    on<OnGetClassLevel>(_onGetClassLevel);
    on<OnDateOfBirthFieldChanged>(_onDateOfBirthFieldChanged);
    on<OnClassFieldChanged>(_onClassFieldChanged);
  }

  void _onFamilyNameFieldChanged(OnFamilyNameFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      familyName: event.familyName,
    ));
  }

  void _onNameFieldChanged(OnNameFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      name: event.name,
    ));
  }

  void _onDateOfBirthFieldChanged(
      OnDateOfBirthFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      birthDay: event.birthday,
    ));
  }

  void _onClassFieldChanged(OnClassFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      classLevel: event.classLevel,
    ));
  }


  Future<void> _onAddClicked(OnAddClicked event, Emitter emit) async {
    Teacher teacher = Teacher(
        id: '',
        name: state.name,
        familyName: state.familyName,
        birthDay: state.birthDay,
        classes: state.classes,
    );

    await for (final event
    in TeacherRepository().addTeacherStream(teacher)) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(isLoading: false));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }

  Future<void> _onGetClassLevel(OnGetClassLevel event, Emitter emit) async {
    await for (final event
    in ClassLevelRepository().getAllClassLevelsStream()) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {

        emit(state.copyWith(isLoading: false, classes: d));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }
}
