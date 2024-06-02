import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  final String id;
  final String? name;
  final String? birthDay;
  final String? familyName;
  final List<String>? classes;

  const Teacher(
      {required this.id,
      this.name,
      this.familyName,
      this.birthDay,
      this.classes});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'] ?? '',
      name: json['name'],
      familyName: json['familyName'],
      birthDay: json['birthDay'],
      classes:
          json['classes'] != null ? List<String>.from(json['classes']) : null,
    );
  }

  // Method to convert Student instance to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'familyName': familyName,
      'birthDay': birthDay,
      'classes': classes,
    };
  }

  factory Teacher.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Teacher(
      id: document.id,
      name: data['name'] ?? '',
      familyName: data['familyName'],
      birthDay: data['birthDay'],
      classes:
      data['classes'] != null ? List<String>.from(data['classes']) : null,
    );
  }
}

class ListOfTeachers {
  final List<Teacher> listOfTeachers;

  const ListOfTeachers({
    required this.listOfTeachers,
  });

  factory ListOfTeachers.fromJson(Map<String, dynamic> json) {
    List<Teacher> teachersList = [];

    json.forEach((key, value) {
      teachersList.add(Teacher.fromJson(value));
    });

    return ListOfTeachers(listOfTeachers: teachersList);
  }



}
