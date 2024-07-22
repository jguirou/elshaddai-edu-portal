import 'dart:async';
import 'package:el_shaddai_edu_portal/domain/repositories/class_level_repository/class_level_repository.dart';
import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../../../domain/entities/students/students.dart';
import '../../../../../../domain/repositories/student_repository/student_repository.dart';
import '../../../../../../utils/helpers/helper_functions.dart';

part 'add_students_event.dart';

part 'add_students_state.dart';

class AddStudentsBloc extends Bloc<AddStudentsEvent, AddStudentsState> {
  AddStudentsBloc() : super(const AddStudentsState()) {
    on<OnFamilyNameFieldChanged>(_onFamilyNameFieldChanged);
    on<OnNameFieldChanged>(_onNameFieldChanged);
    on<OnDateOfBirthFieldChanged>(_onDateOfBirthFieldChanged);
    on<OnFatherNameFieldChanged>(_onFatherNameFieldChanged);
    on<OnMotherNameFieldChanged>(_onMotherNameFieldChanged);
    on<OnMotherFamilyNameFieldChanged>(_onMotherFamilyNameFieldChanged);
    on<OnAddClicked>(_onAddClicked);
    on<OnGetClassLevel>(_onGetClassLevel);
    on<OnAgeFieldChanged>(_onAgeFieldChanged);
    on<OnClassFieldChanged>(_onClassFieldChanged);
    on<OnGenderFieldChanged>(_onGenderFieldChanged);
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

  void _onMotherNameFieldChanged(OnMotherNameFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      motherName: event.name,
    ));
  }
  void _onGenderFieldChanged(OnGenderFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      gender: event.gender,
    ));
  }

  void _onMotherFamilyNameFieldChanged(
      OnMotherFamilyNameFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      motherFamilyName: event.name,
    ));
  }

  void _onFatherNameFieldChanged(OnFatherNameFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      fatherName: event.name,
    ));
  }

  void _onAgeFieldChanged(OnAgeFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      age: event.age,
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
    Student student = Student(
        id: '',
        name: state.name,
        familyName: state.familyName,
        birthDay: state.birthDay,
        classLevel: state.classLevel,
        fatherName: state.fatherName,

        motherName: state.motherName,
        motherFamilyName: state.motherFamilyName,
        schoolFees: {
    for (var date
    in List.generate(12, (index) => DateTime(2022, index + 1)))
    DateFormat.MMMM().format(date): 0
    }
    );
    final schoolYear = HelperFunctions.getActualSchoolYear();


    await for (final event
    in StudentRepository().addStudentStream(student, schoolYear )) {
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
