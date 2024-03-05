import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:firebase_database/firebase_database.dart';

part 'add_teachers_event.dart';

part 'add_teachers_state.dart';

class AddTeachersBloc extends Bloc<AddTeachersEvent, AddTeachersState> {
  AddTeachersBloc() : super(AddTeachersState()) {
    on<InitializeDatabase>(_initializeDatabase);
    on<OnFamilyNameFieldChanged>(_onFamilyNameFieldChanged);
    on<OnNameFieldChanged>(_onNameFieldChanged);
    on<OnAddClicked>(_onAddClicked);
    on<OnClassClicked>(_onClassClicked);
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

  void _initializeDatabase(InitializeDatabase event, Emitter emit) {
    final database = FirebaseDatabase.instance.ref();

    final teachers = database.child("teachers/").push();
    emit(state.copyWith(
      databaseReference: database,
      teachersReference: teachers,
    ));
  }

  void _onAddClicked(OnAddClicked event, Emitter emit) {
    final newStudents = state.databaseReference?.child("teachers/").push();
    String userId = newStudents!.key!;
    newStudents.set({
      'id': userId,
      'name': state.name,
      'familyName': state.familyName,
      'birthDay': state.birthDay,
      'classes': state.classLevel
    });

    emit(state.copyWith(
      name: '',
      familyName: '',
      classLevel: [],
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
