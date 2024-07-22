part of 'students_bloc.dart';

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();
}

/*class InitializeDatabase extends StudentsEvent {
  const InitializeDatabase();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}*/

class OnGetStudents extends StudentsEvent {
  const OnGetStudents(this.schoolYear);
  final String schoolYear;

  @override
  // TODO: implement props
  List<Object?> get props => [schoolYear];
}

class OnEditStudentsData extends StudentsEvent {
  const OnEditStudentsData(this.newStudents);

  final Student newStudents;

  @override
  // TODO: implement props
  List<Object?> get props => [newStudents];
}

class OnSelectSchoolYear extends StudentsEvent {
  const OnSelectSchoolYear();
  //final String schoolYear;


  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class OnGetAllSchoolYears extends StudentsEvent {
  const OnGetAllSchoolYears();


  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class OnDeletedStudent extends StudentsEvent {
  const OnDeletedStudent(this.id, this.schoolYear);

  final String id;
  final String schoolYear;

  @override
  // TODO: implement props
  List<Object?> get props => [id,schoolYear];
}
