import 'package:firebase_database/firebase_database.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/teachers/teachers.dart';
import '../../../../domain/repositories/admin_repository/admin_repository.dart';

part 'teachers_event.dart';

part 'teachers_state.dart';

class TeachersBloc extends Bloc<TeachersEvent, TeachersState> {
  TeachersBloc() : super(const TeachersState()) {
    on<InitializeDatabase>(_initializeDatabase);
    on<OnGetTeachers>(_onGetTeachers);
    on<OnEditTeachersData>(_onEditTeachersData);
    on<OnDeletedTeacher>(_onDeleteTeacher);
  }

  void _initializeDatabase(InitializeDatabase event, Emitter emit) {
    final database = FirebaseDatabase.instance.ref();

    final teachers = database.child("teachers/").push();
    emit(state.copyWith(
      databaseReference: database,
      teachersReference: teachers,

    ));
  }

  void _onGetTeachers(OnGetTeachers event, Emitter emit) async {
    await for (final event
        in AdminRepository().getTeachersStream(state.databaseReference!)) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(isLoading: false, teachersList: d.listOfTeachers));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }

  void _onEditTeachersData(OnEditTeachersData event, Emitter emit) async {
    await for (final event in AdminRepository()
        .updateTeachersStream(state.databaseReference!, event.newTeachers)) {
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

  void _onDeleteTeacher(OnDeletedTeacher event, Emitter emit) async {
    await for (final event
    in AdminRepository().deleteTeacherStream(state.databaseReference!, event.id)) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(isLoading: false, ));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }
}
