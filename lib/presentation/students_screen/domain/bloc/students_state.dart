part of 'students_bloc.dart';

class StudentsState extends Equatable {
  final bool isLoading;
  final List<String>? listOfSchoolYear;
  final List<Students> studentsList;

  final DatabaseReference? databaseReference;
  final DatabaseReference? studentsReference;
  final bool isOk;

  const StudentsState(  {
    this.isLoading = false,
    this.studentsList = const [],
    this.databaseReference,
    this.studentsReference,
    this.listOfSchoolYear,
    this.isOk = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isOk,isLoading, studentsList, databaseReference, studentsReference, listOfSchoolYear];

  StudentsState copyWith({
    bool? isLoading,
    List<String>? listOfSchoolYear,
    List<Students>? studentsList,
    DatabaseReference? databaseReference,
    DatabaseReference? studentsReference,
    bool? isOk,
  }) {
    return StudentsState(
      isLoading: isLoading ?? this.isLoading,
      listOfSchoolYear: listOfSchoolYear ?? this.listOfSchoolYear,
      studentsList: studentsList ?? this.studentsList,
      databaseReference: databaseReference ?? this.databaseReference,
      studentsReference: studentsReference ?? this.studentsReference,
      isOk: isOk ?? this.isOk,
    );
  }
}
