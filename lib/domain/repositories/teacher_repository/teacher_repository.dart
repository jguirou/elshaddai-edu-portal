import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/resource.dart';

import '../../entities/teachers/teachers.dart';

class TeacherRepository {
  final _db = FirebaseFirestore.instance;

  /// -- Get Teachers
  Future<Resource<List<Teacher>>> getAllTeachers() async {
    try {
      final snapshot = await _db.collection('Teachers').get();

      final list = snapshot.docs
          .map((document) => Teacher.fromSnapshot(document))
          .toList();
      return Resource.success(list);
    } catch (e) {
      print("when getting teacher data : $e");
      return Resource.error("error: $e");
    }
  }

  Stream<Resource<List<Teacher>>> getAllTeachersStream() async* {
    try {
      final result = await getAllTeachers();

      if (result is Success<List<Teacher>>) {
        yield Resource.success(result.data);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }

  /// -- Add Students
  Future<Resource<void>> addTeacher(Teacher teacher) async {
    try {
      final docRef = _db.collection('Teachers').doc();
      teacher = Teacher(
        id: docRef.id,
        name: teacher.name,
        familyName: teacher.familyName,
        birthDay: teacher.birthDay,
        classes: teacher.classes,

      );

      await docRef.set(teacher.toMap());
      return Resource.success(null);
    } catch (e) {
      return Resource.error("Error: $e");
    }
  }

  Stream<Resource<void>> addTeacherStream(Teacher teacher) async* {
    try {
      final result = await addTeacher(teacher);

      if (result is Success) {
        yield Resource.success("Teacher registered");
      } else if (result is Error) {
        yield Resource.error(result.message ?? "Unknown error occurred");
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }

  /// -- Update students data
  Future<Resource<void>> updateTeacher(Teacher teacher) async {
    try {
      await _db.collection('Teachers').doc(teacher.id).update(teacher.toMap());
      return Resource.success(null);
    } catch (e) {
      print("when updating student data : $e");
      return Resource.error("error: $e");
    }
  }

  /// Stream to update a student
  Stream<Resource<void>> updateTeacherStream(Teacher teacher) async* {
    try {
      final result = await updateTeacher(teacher);
      if (result is Success<void>) {
        yield Resource.success(null);
      }
    } catch (e) {
      yield Resource.error("Error: $e");
    }
  }
}
