import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class Student {
  final String id;
  final String? name;
  final String? birthDay;
  final String? familyName;
  final String? classLevel;
  final String? fatherName;
  final String? motherName;
  final String? motherFamilyName;
  final Map<String, int>? schoolFees;

  const Student({
    required this.id,
    this.name,
    this.familyName,
    this.birthDay,
    this.classLevel,
    this.fatherName,
    this.motherName,
    this.motherFamilyName,
    this.schoolFees,
  });

  /// Empty helper function
  static Student empty() => Student(
          id: "",
          name: "",
          familyName: "",
          birthDay: "",
          classLevel: "",
          fatherName: "",
          motherFamilyName: "",
          motherName: "",
          schoolFees: {
            for (var date
                in List.generate(12, (index) => DateTime(2022, index + 1)))
              DateFormat.MMMM().format(date): 0
          });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
      name: json['name'],
      familyName: json['familyName'],
      birthDay: json['birthDay'],
      classLevel: json['classLevel'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      motherFamilyName: json['motherFamilyName'],
      schoolFees: json['schoolFees'] != null
          ? Map<String, int>.from(json['schoolFees'])
          : null,
    );
  }

  // Method to convert Student instance to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'familyName': familyName,
      'birthDay': birthDay,
      'classLevel': classLevel,
      'fatherName': fatherName,
      'motherName': motherName,
      'motherFamilyName': motherFamilyName,
      'schoolFees': schoolFees
    };
  }

  factory Student.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Student(
      id: document.id,
      name: data['name'] ?? '',
      familyName: data['familyName'],
      birthDay: data['birthDay'],
      classLevel: data['classLevel'],
      fatherName: data['fatherName'],
      motherName: data['motherName'],
      motherFamilyName: data['motherFamilyName'],
      schoolFees: data['schoolFees'] != null
          ? Map<String, int>.from(data['schoolFees'])
          : null,
    );
  }
}

class ListOfStudents {
  final List<Student> listOfStudents;

  const ListOfStudents({
    required this.listOfStudents,
  });

  factory ListOfStudents.fromJson(Map<String, dynamic> json) {
    List<Student> studentsList = [];

    json.forEach((key, value) {
      studentsList.add(Student.fromJson(value));
    });

    return ListOfStudents(listOfStudents: studentsList);
  }
}
