import 'package:firebase_database/firebase_database.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/admin_repository/admin_repository.dart';
import '../model/teachers.dart';

part 'teachers_event.dart';
part 'teachers_state.dart';

class TeachersBloc extends Bloc<TeachersEvent, TeachersState> {
  TeachersBloc() : super(const TeachersState()) {
    on<InitializeDatabase>(_initializeDatabase);
    on<OnGetTeachers>(_onGetTeachers);
    on<OnEditTeachersData>(_onEditTeachersData);
  }
  void _initializeDatabase(InitializeDatabase event, Emitter emit) {
    final database = FirebaseDatabase.instance.ref();

    final students = database.child("students/").push();
    emit(state.copyWith(
      databaseReference: database,
      studentsReference: students,
    ));
  }
  void _onGetTeachers(OnGetTeachers event, Emitter emit) async{
    await for(final event  in AdminRepository().getTeachersStream(state.databaseReference!) ){
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(
            isLoading: false,
            teachersList: d.listOfTeachers
        ));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }
  void _onEditTeachersData(OnEditTeachersData event, Emitter emit) async{
    final studentId = event.newTeachers.id;

    await state.databaseReference?.child("teachers/$studentId").update(
      event.newTeachers.toMap(),
    );
  }
}