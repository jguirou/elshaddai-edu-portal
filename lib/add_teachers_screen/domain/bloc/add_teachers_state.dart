part of 'add_teachers_bloc.dart';

class AddTeachersState extends Equatable {
  final String name;
  final String familyName;
  final String? birthDay;
  final List<String> classLevel;
  final DatabaseReference? databaseReference;
  final DatabaseReference? teachersReference;
  final List<String>? classes;

  const AddTeachersState({
    this.name = '',
    this.familyName = '',
    this.birthDay,
    this.classLevel = const [],
    this.databaseReference,
    this.teachersReference,
    this.classes,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [name, familyName, databaseReference, teachersReference, classes, birthDay , classLevel];

  AddTeachersState copyWith({
    String? name,
    String? familyName,
    String? birthDay,
    List<String>? classLevel,
    DatabaseReference? databaseReference,
    DatabaseReference? teachersReference,
    List<String>? classes,
  }) {
    return AddTeachersState(
      name: name ?? this.name,
      familyName: familyName ?? this.familyName,
      birthDay: birthDay ?? this.birthDay,
      classLevel: classLevel ?? this.classLevel,
      databaseReference: databaseReference ?? this.databaseReference,
      teachersReference: teachersReference ?? this.teachersReference,
      classes: classes ?? this.classes,
    );
  }
}
