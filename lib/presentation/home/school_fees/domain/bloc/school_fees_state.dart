part of 'school_fees_bloc.dart';

class SchoolFeesState extends Equatable {
  final bool isLoading;
  final List<Student> studentsList;
  final List<String>? listOfSchoolYear;

  final DatabaseReference? databaseReference;
  final DatabaseReference? studentsReference;

  const SchoolFeesState( {
    this.isLoading = false,
    this.studentsList = const [],
    this.listOfSchoolYear = const [],
    this.databaseReference,
    this.studentsReference,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isLoading, studentsList, listOfSchoolYear, databaseReference, studentsReference];

  SchoolFeesState copyWith({
    bool? isLoading,
    List<Student>? studentsList,
    List<String>? listOfSchoolYear,
    DatabaseReference? databaseReference,
    DatabaseReference? studentsReference,
  }) {
    return SchoolFeesState(
      isLoading: isLoading ?? this.isLoading,
      studentsList: studentsList ?? this.studentsList,
      listOfSchoolYear: listOfSchoolYear ?? this.listOfSchoolYear,
      databaseReference: databaseReference ?? this.databaseReference,
      studentsReference: studentsReference ?? this.studentsReference,
    );
  }
}
