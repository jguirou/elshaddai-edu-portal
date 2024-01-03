import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/admin_repository/admin_repository.dart';
import '../../../students_screen/domain/model/students.dart';
import 'package:firebase_database/firebase_database.dart';
part 'school_fees_event.dart';
part 'school_fees_state.dart';

class SchoolFeesBloc extends Bloc<SchoolFeesEvent, SchoolFeesState> {
  SchoolFeesBloc() : super(const SchoolFeesState()) {
    on<InitializeDatabase>(_initializeDatabase);
    on<OnGetStudents>(_onGetStudents);
    on<OnEditStudentsData>(_onEditStudentsData);
    on<OnSchoolFeesUpdated>(_onSchoolFeesUpdated);
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
            studentsList: d.listOfStudents
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

  void _onSchoolFeesUpdated(OnSchoolFeesUpdated event, Emitter emit) async{
    await state.databaseReference
        ?.child('students')
        .child(event.studentId)
        .child('schoolFees')
        .set(event.schoolFees);
  }
}
