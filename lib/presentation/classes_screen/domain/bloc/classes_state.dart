part of 'classes_bloc.dart';

class ClassesState extends Equatable {
  final String name;
  final String familyName;
  final String fatherName;
  final String motherName;
  final String motherFamilyName;
  final String age;
  final String? birthDay;
  final String classLevel;
  final DatabaseReference? databaseReference;
  final DatabaseReference? studentsReference;
  final List<String>? classes;

  const ClassesState({
    this.name = '',
    this.familyName = '',
    this.fatherName = '',
    this.birthDay,
    this.motherFamilyName = '',
    this.motherName = '',
    this.age = '',
    this.classLevel = '',
    this.databaseReference,
    this.studentsReference,
    this.classes,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        familyName,
        birthDay,
        fatherName,
        motherName,
        motherFamilyName,
        databaseReference,
        studentsReference,
        classes,
        age,
        classLevel
      ];

  ClassesState copyWith({
    String? name,
    String? familyName,
    String? fatherName,
    String? motherName,
    String? motherFamilyName,
    String? age,
    String? birthDay,
    String? classLevel,
    DatabaseReference? databaseReference,
    DatabaseReference? studentsReference,
    List<String>? classes,
  }) {
    return ClassesState(
      name: name ?? this.name,
      familyName: familyName ?? this.familyName,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      motherFamilyName: motherFamilyName ?? this.motherFamilyName,
      age: age ?? this.age,
      birthDay: birthDay ?? this.birthDay,
      classLevel: classLevel ?? this.classLevel,
      databaseReference: databaseReference ?? this.databaseReference,
      studentsReference: studentsReference ?? this.studentsReference,
      classes: classes ?? this.classes,
    );
  }
}
