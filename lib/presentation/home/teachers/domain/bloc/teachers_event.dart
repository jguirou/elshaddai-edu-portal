part of 'teachers_bloc.dart';

abstract class TeachersEvent extends Equatable {
  const TeachersEvent();
}

class InitializeDatabase extends TeachersEvent {
  const InitializeDatabase();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnGetTeachers extends TeachersEvent {
  const OnGetTeachers();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnEditTeachersData extends TeachersEvent {
  const OnEditTeachersData(this.newTeachers);

  final Teacher newTeachers;

  @override
  // TODO: implement props
  List<Object?> get props => [newTeachers];
}
