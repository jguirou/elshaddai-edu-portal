import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../repositories/admin_repository/admin_repository.dart';
import '../model/students.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc() : super(const StudentsState()) {
    on<InitializeDatabase>(_initializeDatabase);
    on<OnGetStudents>(_onGetStudents);
    on<OnEditStudentsData>(_onEditStudentsData);
  }
  void _initializeDatabase(InitializeDatabase event, Emitter emit) {
    final database = FirebaseDatabase.instance.ref();

    final students = database.child("students/").push();
    emit(state.copyWith(
      databaseReference: database,
      studentsReference: students,
    ));
  }
  void _onGetStudents(OnGetStudents event, Emitter emit) async{
    await for(final event  in AdminRepository().getStudentsStream(state.databaseReference!) ){
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(
          isLoading: false,
          studentsList: d?.listOfStudents
        ));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }
  void _onEditStudentsData(OnEditStudentsData event, Emitter emit) async{
    final studentId = event.newStudents.id;

    await state.databaseReference?.child("students/$studentId").update(
      event.newStudents.toMap(),
    );
  }
}
