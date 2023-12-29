import 'dart:async';

import 'package:el_shaddai_edu_portal/students_screen/domain/model/students.dart';
import 'package:el_shaddai_edu_portal/teachers_screen/domain/model/teachers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../core/resource.dart';
//import 'package:flutter/material.dart';

enum Class {
  petiteSection,
  moyenneSection,
  grandeSection,
  premiereAnnee,
  deuxiemeAnnee,
  troisiemeAnnee,
  quatriemeAnnee,
  cinquiemeAnnee,
  sixiemeAnnee,
  septiemeAnnee,
  huitiemeAnnee,
  neuviemeAnnee,
}

enum FirebaseAuthError {
  invalidEmail,
  userNotFound,
  wrongPassword,
  weakPassword,
  emailAlreadyInUse,
  operationNotAllowed,
  userDisabled,
  tooManyRequests,
  undefined,
  noError,
}

extension FirebaseAuthErrorExtension on FirebaseAuthError {
  static FirebaseAuthError fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return FirebaseAuthError.invalidEmail;
      case 'user-not-found':
        return FirebaseAuthError.userNotFound;
      case 'wrong-password':
        return FirebaseAuthError.wrongPassword;
      case 'weak-password':
        return FirebaseAuthError.weakPassword;
      case 'email-already-in-use':
        return FirebaseAuthError.emailAlreadyInUse;
      case 'operation-not-allowed':
        return FirebaseAuthError.operationNotAllowed;
      case 'user-disabled':
        return FirebaseAuthError.userDisabled;
      case 'too-many-requests':
        return FirebaseAuthError.tooManyRequests;
      default:
        return FirebaseAuthError.undefined;
    }
  }
}

class AdminRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Resource<ListOfStudents>?> getStudents(
      DatabaseReference databaseReference) async {
    ListOfStudents data = const ListOfStudents(listOfStudents: []);
    try {
      databaseReference.child('students/').onValue.listen((event) {
        final val = event.snapshot.value as Map<String, dynamic>;
     data = ListOfStudents.fromJson(val);

      });
      return Resource.success(data);
    } catch (e) {
      return Resource.error("error: $e");
    }
  }
  Stream<Resource<ListOfStudents>> getStudentsStream(DatabaseReference databaseReference) {
    final StreamController<Resource<ListOfStudents>> controller =
    StreamController<Resource<ListOfStudents>>();

    databaseReference.child('students/').onValue.listen((event) {
      final data = event.snapshot.value as Map<String, dynamic>;
      if (data != null) {
        try {
          final listOfStudents = ListOfStudents.fromJson(data);
          controller.add(Resource.success(listOfStudents));
        } catch (e) {
          controller.add(Resource.error('Error parsing data: $e'));
        }
      } else {
        controller.add(Resource.error('No data available'));
      }
    });

    return controller.stream;
  }

  Stream<Resource<ListOfTeachers>> getTeachersStream(DatabaseReference databaseReference) {
    final StreamController<Resource<ListOfTeachers>> controller =
    StreamController<Resource<ListOfTeachers>>();

    databaseReference.child('teachers/').onValue.listen((event) {
      final data = event.snapshot.value as Map<String, dynamic>;
      if (data != null) {
        try {
          final listOfTeachers = ListOfTeachers.fromJson(data);
          controller.add(Resource.success(listOfTeachers));
        } catch (e) {
          controller.add(Resource.error('Error parsing data: $e'));
        }
      } else {
        controller.add(Resource.error('No data available'));
      }
    });

    return controller.stream;
  }


  Future<Resource<User>?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return Resource.success(userCredential.user!);
    } catch (e) {
      return Resource.error("error: $e");
    }
  }

  Stream<Resource<User?>> signUp(String email, String password) async* {
    try {
      final result = await signUpWithEmailAndPassword(email, password);

      if (result != null && result is Success<User>) {
        yield Resource.success(result.data);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Stream<Resource<User?>> signIn(String email, String password) async* {
    try {
      final result = await signInWithEmailAndPassword(email, password);

      yield Resource.success(result);
    } catch (e) {
      if (e is FirebaseAuthException) {
        yield Resource.error(e.code);
      }
    }
  }
}