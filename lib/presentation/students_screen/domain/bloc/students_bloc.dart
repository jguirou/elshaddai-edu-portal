import 'package:bloc/bloc.dart';
import 'package:el_shaddai_edu_portal/utils/app_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../domain/entities/students/students.dart';
import '../../../../domain/repositories/admin_repository/admin_repository.dart';

part 'students_event.dart';

part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc() : super(const StudentsState()) {
    on<InitializeDatabase>(_initializeDatabase);
    on<OnGetStudents>(_onGetStudents);
    on<OnEditStudentsData>(_onEditStudentsData);
    on<OnDeletedStudent>(_onDeleteStudent);
    on<OnSelectSchoolYear>(onSelectSchoolYear);
    on<OnGetAllSchoolYears>(_onGetAllSchoolYears);
    on<OnReload>(_onReload);
  }

  void _initializeDatabase(InitializeDatabase event, Emitter<StudentsState> emit) {
    final database = FirebaseDatabase.instance.ref();

    final students = database.child("students/").push();
    emit(state.copyWith(
      databaseReference: database,
      studentsReference: students,
    ));

  }
  void _onReload(OnReload event, Emitter<StudentsState> emit ) async {
    emit(state.copyWith(
      isOk: event.isOk,
    ));
  }

  void _onGetAllSchoolYears(OnGetAllSchoolYears event, Emitter<StudentsState> emit) async {
    await for (final event in AdminRepository()
        .getAllSchoolYearsStream(state.databaseReference!)) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));
      }, success: (d) {
        emit(state.copyWith(isLoading: false, listOfSchoolYear: d));
      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }

  void _onGetStudents(OnGetStudents event, Emitter<StudentsState> emit) async {
    await for (final event in AdminRepository().getStudentsStream(
        state.databaseReference!, event.schoolYear)) {
      event.when(loading: () {
        emit(state.copyWith(
          isLoading: true,
        ));

      }, success: (d) {
        emit(state.copyWith(isLoading: false, studentsList: d.listOfStudents));

      }, error: (e) {
        emit(state.copyWith(
          isLoading: false,
        ));
      });
    }
  }

  void _onDeleteStudent(OnDeletedStudent event, Emitter<StudentsState> emit) async {
    await for (final event in AdminRepository()
        .deleteStudentsStream(state.databaseReference!, event.id, event.schoolYear )) {
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

  void _onEditStudentsData(OnEditStudentsData event, Emitter<StudentsState> emit) async {
    await for (final event in AdminRepository()
        .updateStudentsStream(state.databaseReference!, event.newStudents)) {
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


  void onSelectSchoolYear(OnSelectSchoolYear event, Emitter<StudentsState> emit) async {
    print("11&&&&&&&&&&&&&&&&&&&&&&&&");
    // Check if 2022-2023 child node exists
    DatabaseEvent snapshot =
    await state.databaseReference!.child('students/').child('2024-2025/').once();
    // Fetch data from 2021-2022 child node
    DatabaseEvent oldDataSnapshot =
    await state.databaseReference!.child('students/').child('2023-2024/').once();

    print("erhfejhhgfgfgfgfgggfg");
    if (!snapshot.snapshot.exists) {
      // Create a new map to store updated data for 2022-2023
      Map<String, dynamic> newData = {};
      Map<dynamic, dynamic>? oldDataMap =
      oldDataSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (oldDataMap != null) {
        Map<String, dynamic> oldData = Map<String, dynamic>.from(oldDataMap);

        // Now you can iterate through each student and update school fees for the new school year
        oldData.forEach((key, value) {
          Map<String, dynamic> studentData = Map<String, dynamic>.from(value);
          studentData['schoolFees'] =
              updateSchoolFeesForNewYear(studentData['schoolFees']);
          newData[key] = studentData;
        });
      }
      print("erhfejhhgfgfgfgfgggfg: ${oldDataMap.toString()} ${newData.toString()}");
      // Add the updated data to the 2022-2023 child node
      await state.databaseReference!
          .child('students/')
          .child('2024-2025/')
          .set(newData);
    }
  }

  Map<String, dynamic> updateSchoolFeesForNewYear(
      Map<String, dynamic> oldSchoolFees) {
    // Update the school fees for the new school year as needed
    // For example, you can increase/decrease the fees or set them to a default value
    // Here, we'll set the fees to 0 for all months
    return oldSchoolFees.map((key, value) => MapEntry(key, 0));
  }
}
