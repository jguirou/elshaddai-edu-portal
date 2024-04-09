part of 'school_fees_bloc.dart';

class SchoolFeesState extends Equatable {
  final bool isLoading;
  final List<Students> studentsList;
  final List<String>? listOfSchoolYear;

  final DatabaseReference? databaseReference;
  final DatabaseReference? studentsReference;

  const SchoolFeesState( {
    this.isLoading = false,
    this.studentsList = const [],
    this.databaseReference,
    this.studentsReference,
    this.listOfSchoolYear,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isLoading, studentsList, databaseReference, studentsReference, listOfSchoolYear,];

  SchoolFeesState copyWith({
    bool? isLoading,
    List<Students>? studentsList,
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
