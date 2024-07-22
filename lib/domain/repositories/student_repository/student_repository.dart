import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/resource.dart';
import '../../entities/students/students.dart';

class StudentRepository {
  final _db = FirebaseFirestore.instance;

  /// -- Get Students
  Future<Resource<List<Student>>> getAllStudents(String schoolYear) async {
    try {

      final snapshot = await _db.collection('Students').doc(schoolYear).collection('Students').get();

      final list = snapshot.docs
          .map((document) => Student.fromSnapshot(document))
          .toList();
      return Resource.success(list);
    } catch (e) {
      print("when getting students data : $e");
      return Resource.error("error: $e");
    }
  }

  Stream<Resource<List<Student>>> getAllStudentsStream(String schoolYear) async* {
    try {
      final result = await getAllStudents(schoolYear);

      if (result is Success<List<Student>>) {
        yield Resource.success(result.data);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }

  /// -- Add Students
  Future<Resource<void>> addStudent(Student student, String schoolYear) async {
    try {
      final docRef = _db.collection('Students').doc(schoolYear).collection('Students').doc();
      student = Student(
          id: docRef.id,
          name: student.name,
          familyName: student.familyName,
          motherName: student.familyName,
          fatherName: student.fatherName,
          motherFamilyName: student.motherFamilyName,
          classLevel: student.classLevel,
          birthDay: student.birthDay,
          schoolFees: student.schoolFees);
      await docRef.set(student.toMap());
      return Resource.success(null);
    } catch (e) {
      print("Error adding student: $e");
      return Resource.error("Error: $e");
    }
  }
  Stream<Resource<void>> addStudentStream(Student student, String schoolYear) async* {
    try {
      final result = await addStudent(student, schoolYear);

      if (result is Success<void>) {
        yield Resource.success(null);
      } else if (result is Error) {

        yield Resource.error(result.message ?? "Unknown error occurred");
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }

  /// -- Update students data
  Future<Resource<void>> updateStudent(Student student, String schoolYear) async {
    try {
      await _db.collection('Students').doc(schoolYear).collection('Students').doc(student.id).update(student.toMap());
      return Resource.success(null);
    } catch (e) {
      print("when updating student data : $e");
      return Resource.error("error: $e");
    }
  }

  /// Stream to update a student
  Stream<Resource<void>> updateStudentStream(Student student, String schoolYear) async* {
    try {
      final result = await updateStudent(student, schoolYear);
      if (result is Success<void>) {
        yield Resource.success(null);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }


  /// Update a specific field of a student
  Future<Resource<void>> updateStudentNestedField(String studentId, String field, dynamic value) async {
    try {
      await _db.collection('Students').doc(studentId).update({
        field: value,
      });
      return Resource.success(null);
    } catch (e) {
      print("when updating student field : $e");
      return Resource.error("error: $e");
    }
  }

  /// Stream to update a specific nested field of a student
  Stream<Resource<void>> updateStudentNestedFieldStream(String studentId, String field, dynamic value) async* {
    try {
      final result = await updateStudentNestedField(studentId, field, value);
      if (result is Success<void>) {
        yield Resource.success(null);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }




  /// delete a student
  Future<Resource<void>> deleteStudent(String studentId, String field, dynamic value) async {
    try {
      await _db.collection('Students').doc(studentId).update({
        field: value,
      });
      return Resource.success(null);
    } catch (e) {
      print("when updating student field : $e");
      return Resource.error("error: $e");
    }
  }


  Future<List<String>> getSchoolYears() async {
    try {
      final QuerySnapshot snapshot = await _db.collection('Students').get();
      List<String> schoolYears = snapshot.docs.map((doc) => doc.id).toList();

      return schoolYears;
    } catch (e) {
      print("Error getting school years: $e");
      return [];
    }
  }

  Stream<Resource<List<String>>> getSchoolYearsStream() async* {
    try {
      final result = await getSchoolYears();

      yield Resource.success(result);
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }


}
