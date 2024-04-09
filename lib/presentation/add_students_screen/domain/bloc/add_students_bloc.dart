import 'dart:async';
import 'package:el_shaddai_edu_portal/utils/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/date_symbol_data_local.dart';
part 'add_students_event.dart';

part 'add_students_state.dart';

class AddStudentsBloc extends Bloc<AddStudentsEvent, AddStudentsState> {
  AddStudentsBloc() : super(AddStudentsState()) {
    on<InitializeDatabase>(_initializeDatabase);
    on<OnGenderFieldChanged>(_onGenderFieldChanged);
    on<OnFamilyNameFieldChanged>(_onFamilyNameFieldChanged);
    on<OnNameFieldChanged>(_onNameFieldChanged);
    on<OnDateOfBirthFieldChanged>(_onDateOfBirthFieldChanged);
    on<OnFatherNameFieldChanged>(_onFatherNameFieldChanged);
    on<OnMotherNameFieldChanged>(_onMotherNameFieldChanged);
    on<OnMotherFamilyNameFieldChanged>(_onMotherFamilyNameFieldChanged);
    on<OnAddClicked>(_onAddClicked);
    on<OnClassClicked>(_onClassClicked);
    on<OnAgeFieldChanged>(_onAgeFieldChanged);
    on<OnClassFieldChanged>(_onClassFieldChanged);
  }
  void _onGenderFieldChanged(OnGenderFieldChanged event, Emitter emit) {
    emit(state.copyWith(
      gender: event.gender,
    ));
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

  void _initializeDatabase(InitializeDatabase event, Emitter emit) {
    final database = FirebaseDatabase.instance.ref();

    final students = database.child("students/").push();
    emit(state.copyWith(
      databaseReference: database,
      studentsReference: students,
    ));
  }

  void _onAddClicked(OnAddClicked event, Emitter emit)  {
    final List<String> schoolMonths = [
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre',
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
    ];
    final schoolYear = AppUtils().getActualSchoolYear();
    final newStudents = state.databaseReference?.child("students/$schoolYear/").push();

    String userId = newStudents!.key!;
    newStudents.set({
      'id': userId,
      'gender': state.gender,
      'name': state.name,
      'familyName': state.familyName,
      'birthDay': state.birthDay,
      'class': state.classLevel,
      'fatherName': state.fatherName,
      'fatherFamilyName': state.familyName,
      'motherName': state.motherName,
      'motherFamilyName': state.motherFamilyName,
      'schoolFees': {
        for (var month
            in schoolMonths)
          month: 0
      }
    });

    emit(state.copyWith(
      name: '',
      familyName: '',
      age: '',
      classLevel: '',
      fatherName: '',
      motherFamilyName: '',
      motherName: '',
    ));
  }

  Future<void> _onClassClicked(OnClassClicked event, Emitter emit) async {
    state.databaseReference?.child("class").once();

    List<String> classes = List.empty(growable: true);
    try {
      DatabaseEvent? databaseEvent =
          await state.databaseReference?.child("class/").once();
      DataSnapshot? snapshot = databaseEvent?.snapshot;

      if (snapshot?.value != null) {
        // Cast the snapshot value to the expected type
        Map<String, dynamic>? data = snapshot?.value as Map<String, dynamic>?;

        if (data != null) {
          // Retrieve and add content from "jardin" node
          Map<String, dynamic>? jardinData = data['jardin'];
          if (jardinData != null) {
            classes.addAll(jardinData.values.cast<String>());
          }

          // Retrieve and add content from "premierCycle" node
          Map<String, dynamic>? premierCycleData = data['premierCycle'];
          if (premierCycleData != null) {
            classes.addAll(premierCycleData.values.cast<String>());
          }

          // Retrieve and add content from "secondCycle" node
          Map<String, dynamic>? secondCycleData = data['secondCycle'];
          if (secondCycleData != null) {
            classes.addAll(secondCycleData.values.cast<String>());
          }
        }
      }

      emit(state.copyWith(
        classes: classes,
      ));
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error accordingly
    }
  }
}
