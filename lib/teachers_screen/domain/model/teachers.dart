class Teachers {
  final String id;
  final String? name;
  final String? birthDay;
  final String? familyName;
  final List<String>? classes;


  const Teachers(
      {required this.id,
        this.name,
        this.familyName,
        this.birthDay,
        this.classes
        });
  factory Teachers.fromJson(Map<String, dynamic> json) {
    return Teachers(
      id: json['id'] ?? '',
      name: json['name'],
      familyName: json['familyName'],

      birthDay: json['birthDay'],
      classes: json['classes'] != null
          ? List<String>.from(json['classes'])
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
      'classes': classes,
    };
  }
}

class ListOfTeachers {
  final List<Teachers> listOfTeachers;

  const ListOfTeachers({
    required this.listOfTeachers,
  });
  factory ListOfTeachers.fromJson(Map<String, dynamic> json) {
    List<Teachers> teachersList = [];

    json.forEach((key, value) {
      teachersList.add(Teachers.fromJson(value));
    });

    return ListOfTeachers(listOfTeachers: teachersList);
  }
}
