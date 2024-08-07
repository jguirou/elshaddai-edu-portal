part of 'add_students_bloc.dart';

class AddStudentsState extends Equatable {
  final bool isLoading;
  final String name;
  final String gender;
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

  const AddStudentsState({
    this.isLoading = false,
    this.name = '',
    this.gender = '',
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
  List<Object?> get props =>
      [
        name,
        gender,
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

  AddStudentsState copyWith({
    bool? isLoading,
    String? name,
    String? gender,
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
    return AddStudentsState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      gender: gender ?? this.gender,
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
