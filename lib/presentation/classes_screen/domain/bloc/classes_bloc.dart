import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

part 'classes_event.dart';

part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  ClassesBloc() : super(const ClassesState()) {
    on<OnClassClicked>(_onClassClicked);
    on<InitializeDatabase>(_initializeDatabase);
  }

  void _initializeDatabase(InitializeDatabase event, Emitter emit) {
    final database = FirebaseDatabase.instance.ref();

    final students = database.child("students/").push();
    emit(state.copyWith(
      databaseReference: database,
      studentsReference: students,
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
