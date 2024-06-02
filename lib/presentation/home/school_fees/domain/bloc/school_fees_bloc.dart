import 'package:bloc/bloc.dart';
import 'package:el_shaddai_edu_portal/domain/repositories/student_repository/student_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:firebase_database/firebase_database.dart';

import '../../../../../domain/entities/students/students.dart';



part 'school_fees_event.dart';

part 'school_fees_state.dart';

class SchoolFeesBloc extends Bloc<SchoolFeesEvent, SchoolFeesState> {
  SchoolFeesBloc() : super(const SchoolFeesState()) {
    on<OnGetStudents>(_onGetStudents);
    on<OnEditStudentsData>(_onEditStudentsData);
    on<OnSchoolFeesUpdated>(_onSchoolFeesUpdated);
  }


  void _onGetStudents(OnGetStudents event, Emitter emit) async {
    await for (final event
        in StudentRepository().getAllStudentsStream()) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(isLoading: false, studentsList: d));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }

  void _onEditStudentsData(OnEditStudentsData event, Emitter emit) async {

    await for (final event in StudentRepository()
        .updateStudentStream(event.newStudents)) {
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

  void _onSchoolFeesUpdated(OnSchoolFeesUpdated event, Emitter emit) async {
    await for (final event in StudentRepository()
        .updateStudentNestedFieldStream(event.studentId, 'schoolFees', event.schoolFees)) {
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
