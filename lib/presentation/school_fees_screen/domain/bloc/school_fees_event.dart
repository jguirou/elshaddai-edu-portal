part of 'school_fees_bloc.dart';

abstract class SchoolFeesEvent extends Equatable {
  const SchoolFeesEvent();
}

class InitializeDatabase extends SchoolFeesEvent {
  const InitializeDatabase();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnGetStudents extends SchoolFeesEvent {
  const OnGetStudents(this.schoolYear);
  final String schoolYear;

  @override
  // TODO: implement props
  List<Object?> get props => [schoolYear];
}

class OnEditStudentsData extends SchoolFeesEvent {
  const OnEditStudentsData(this.newStudents, this.schoolYear);

  final Students newStudents;
  final String schoolYear;

  @override
  // TODO: implement props
  List<Object?> get props => [newStudents,schoolYear];
}
class OnGetAllSchoolYears extends SchoolFeesEvent {
  const OnGetAllSchoolYears();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnSchoolFeesUpdated extends SchoolFeesEvent {
  const OnSchoolFeesUpdated(this.studentId, this.schoolFees, this.schoolYear);

  final String studentId;
  final Map<String, int> schoolFees;
  final String schoolYear;

  @override
  // TODO: implement props
  List<Object?> get props => [studentId, schoolFees, schoolYear];
}
