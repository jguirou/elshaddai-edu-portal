class Students {
  final String id;
  final String? gender;
  final String? name;
  final String? birthDay;
  final String? familyName;
  final String? classLevel;
  final String? fatherName;
  final String? motherName;
  final String? motherFamilyName;
  final Map<String, int>? schoolFees;

  const Students({
    required this.id,
    this.gender,
    this.name,
    this.familyName,
    this.birthDay,
    this.classLevel,
    this.fatherName,
    this.motherName,
    this.motherFamilyName,
    this.schoolFees,
  });

  factory Students.fromJson(Map<String, dynamic> json) {
    return Students(
      id: json['id'] ?? '',
      gender: json['gender'],
      name: json['name'],
      familyName: json['familyName'],
      birthDay: json['birthDay'],
      classLevel: json['class'],
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
      'gender': gender,
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
}

class ListOfStudents {
  final List<Students> listOfStudents;

  const ListOfStudents({
    required this.listOfStudents,
  });

  factory ListOfStudents.fromJson(Map<String, dynamic> json) {
    List<Students> studentsList = [];

    json.forEach((key, value) {
      studentsList.add(Students.fromJson(value));
    });

    return ListOfStudents(listOfStudents: studentsList);
  }
}
