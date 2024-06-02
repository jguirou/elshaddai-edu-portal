import 'package:el_shaddai_edu_portal/domain/repositories/teacher_repository/teacher_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/teachers/teachers.dart';

part 'teachers_event.dart';

part 'teachers_state.dart';

class TeachersBloc extends Bloc<TeachersEvent, TeachersState> {
  TeachersBloc() : super(const TeachersState()) {

    on<OnGetTeachers>(_onGetTeachers);
    on<OnEditTeachersData>(_onEditTeachersData);
  }


  void _onGetTeachers(OnGetTeachers event, Emitter emit) async {
    await for (final event
        in TeacherRepository().getAllTeachersStream()) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(isLoading: false, teachersList: d));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }

  void _onEditTeachersData(OnEditTeachersData event, Emitter emit) async {
    await for (final event in TeacherRepository()
        .updateTeacherStream(event.newTeachers)) {
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
