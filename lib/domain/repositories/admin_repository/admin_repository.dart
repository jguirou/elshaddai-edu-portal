import 'dart:async';
import 'package:el_shaddai_edu_portal/domain/entities/students/students.dart';
import 'package:el_shaddai_edu_portal/domain/entities/teachers/teachers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/resource.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';

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

  Future<Resource<bool>?> updateStudents(
      DatabaseReference databaseReference, Student students) async {
    try {
      await databaseReference.child("students/${students.id}").update(
            students.toMap(),
          );
      return Resource.success(true);
    } catch (e) {
      return Resource.error("error: $e");
    }
  }

  Stream<Resource<bool>> updateStudentsStream(
      DatabaseReference databaseReference, Student students) async* {
    try {
      final result = await updateStudents(databaseReference, students);

      if (result != null && result is Success<bool>) {
        yield Resource.success(result.data);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }

  Future<Resource<bool>?> updateTeachers(
      DatabaseReference databaseReference, Teacher teachers) async {
    try {
      await databaseReference.child("teachers/${teachers.id}").update(
            teachers.toMap(),
          );
      return Resource.success(true);
    } catch (e) {
      return Resource.error("error: $e");
    }
  }

  Stream<Resource<bool>> updateTeachersStream(
      DatabaseReference databaseReference, Teacher teachers) async* {
    try {
      final result = await updateTeachers(databaseReference, teachers);

      if (result != null && result is Success<bool>) {
        yield Resource.success(result.data);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }

  Stream<Resource<ListOfStudents>> getStudentsStream(
      DatabaseReference databaseReference) {
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

  Stream<Resource<ListOfTeachers>> getTeachersStream(
      DatabaseReference databaseReference) {
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

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try{
      return await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch(e){
      throw CustomFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e){
      throw CustomFirebaseExceptions(e.code).message;

    } on FormatException catch(_){
      throw CustomFormatException();

    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }



  Stream<Resource<UserCredential>> signIn(String email, String password) async* {
    try {
      final result = await signInWithEmailAndPassword(email, password);

      yield Resource.success(result);
    } catch (e) {
      yield Resource.error(e);
    }
  }
}
