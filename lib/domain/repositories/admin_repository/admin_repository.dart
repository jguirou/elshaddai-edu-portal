import 'dart:async';
import 'package:el_shaddai_edu_portal/domain/entities/students/students.dart';
import 'package:el_shaddai_edu_portal/domain/entities/teachers/teachers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/resource.dart';

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
      DatabaseReference databaseReference, Students students) async {
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
      DatabaseReference databaseReference, Students students) async* {
    try {
      final result = await updateStudents(databaseReference, students);

      if (result != null && result is Success<bool>) {
        yield Resource.success(result.data);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }

  Future<Resource<bool>?> deleteStudent(DatabaseReference databaseReference, String studentId, String schoolYear) async {
    try {
      await databaseReference.child("students/$schoolYear/$studentId").remove();
      return Resource.success(true);
    } catch (e) {
      return Resource.error("Error: $e");
    }
  }
  Stream<Resource<bool>> deleteStudentsStream(
      DatabaseReference databaseReference, String id, String schoolYear) async* {
    try {
      final result = await deleteStudent(databaseReference, id, schoolYear);

      if (result != null && result is Success<bool>) {
        yield Resource.success(result.data);
      }
    } catch (e) {

      yield Resource.error("Error ghh: $e");
    }
  }

  Future<Resource<bool>?> deleteTeacher(DatabaseReference databaseReference, String teacherId) async {
    try {
      await databaseReference.child("teachers/$teacherId").remove();
      return Resource.success(true);
    } catch (e) {
      print("Error deleting teacher: $e");
      return Resource.error("Error ghh: $e");
    }
  }
  Stream<Resource<bool>> deleteTeacherStream(
      DatabaseReference databaseReference, String id) async* {
    try {
      final result = await deleteTeacher(databaseReference, id);

      if (result != null && result is Success<bool>) {
        yield Resource.success(result.data);
      }
    } catch (e) {
      print("Error deleting teacher: $e");
      yield Resource.error("Error ghh: $e");
    }
  }

  Future<Resource<bool>?> updateTeachers(
      DatabaseReference databaseReference, Teachers teachers) async {
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
      DatabaseReference databaseReference, Teachers teachers) async* {
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
      DatabaseReference databaseReference, String schoolYear) {
    final StreamController<Resource<ListOfStudents>> controller =
        StreamController<Resource<ListOfStudents>>();

    databaseReference.child('students/').child('$schoolYear/').onValue.listen((event) {
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

  Future<List<String>> getAllSchoolYears(DatabaseReference databaseReference) async {
    List<String> schoolYears = [];

    try {
      DatabaseEvent dataSnapshot = await databaseReference.child('students/').once();

      // Check if the snapshot has data
      if (dataSnapshot.snapshot.value != null) {
        // Iterate over the children and extract the keys
        (dataSnapshot.snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
          schoolYears.add(key);
        });
      }
    } catch (e) {
      print('Error fetching school years: $e');
    }

    return schoolYears;
  }
  Stream<Resource<List<String>>> getAllSchoolYearsStream(
      DatabaseReference databaseReference) async* {
    try {
      final result = await getAllSchoolYears(databaseReference);
      yield Resource.success(result);
    } catch (e) {
      yield Resource.error("Error: $e");
    }
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
