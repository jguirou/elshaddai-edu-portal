part of 'teachers_bloc.dart';

class TeachersState extends Equatable {
  final bool isLoading;
  final List<Teachers> teachersList;

  final DatabaseReference? databaseReference;
  final DatabaseReference? studentsReference;

  const TeachersState({
    this.isLoading = false,
    this.teachersList = const [],
    this.databaseReference,
    this.studentsReference,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isLoading, teachersList, databaseReference, studentsReference];

  TeachersState copyWith({
    bool? isLoading,
    List<Teachers>? teachersList,
    DatabaseReference? databaseReference,
    DatabaseReference? studentsReference,
  }) {
    return TeachersState(
      isLoading: isLoading ?? this.isLoading,
      teachersList: teachersList ?? this.teachersList,
      databaseReference: databaseReference ?? this.databaseReference,
      studentsReference: studentsReference ?? this.studentsReference,
    );
  }
}
