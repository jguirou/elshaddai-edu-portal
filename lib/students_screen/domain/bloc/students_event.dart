part of 'students_bloc.dart';

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();
}

class InitializeDatabase extends StudentsEvent {
  const InitializeDatabase();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class OnGetStudents extends StudentsEvent {
  const OnGetStudents();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnEditStudentsData extends StudentsEvent {
  const OnEditStudentsData(this.newStudents);
  final Students  newStudents;

  @override
  // TODO: implement props
  List<Object?> get props => [newStudents];
}