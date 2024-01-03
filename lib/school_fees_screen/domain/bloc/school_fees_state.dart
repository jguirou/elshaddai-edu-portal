part of 'school_fees_bloc.dart';


class SchoolFeesState extends Equatable {
  final bool isLoading;
  final List<Students> studentsList;

  final DatabaseReference? databaseReference;
  final DatabaseReference? studentsReference;

  const SchoolFeesState({
    this.isLoading = false,
    this.studentsList = const [],
    this.databaseReference,
    this.studentsReference,

  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isLoading, studentsList, databaseReference, studentsReference];

  SchoolFeesState copyWith({
    bool? isLoading,
    List<Students>? studentsList,
    DatabaseReference? databaseReference,
    DatabaseReference? studentsReference,
  }) {
    return SchoolFeesState(
      isLoading: isLoading ?? this.isLoading,
      studentsList: studentsList ?? this.studentsList,
      databaseReference: databaseReference ?? this.databaseReference,
      studentsReference: studentsReference ?? this.studentsReference,
    );
  }
}
