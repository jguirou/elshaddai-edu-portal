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
  const OnGetStudents();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnEditStudentsData extends SchoolFeesEvent {
  const OnEditStudentsData(this.newStudents);
  final Students  newStudents;

  @override
  // TODO: implement props
  List<Object?> get props => [newStudents];
}


class OnSchoolFeesUpdated extends SchoolFeesEvent {
  const OnSchoolFeesUpdated(this.studentId, this.schoolFees);
  final String  studentId;
  final Map<String, int> schoolFees;

  @override
  // TODO: implement props
  List<Object?> get props => [studentId, schoolFees];
}