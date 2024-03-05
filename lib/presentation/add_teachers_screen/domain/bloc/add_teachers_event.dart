part of 'add_teachers_bloc.dart';

abstract class AddTeachersEvent extends Equatable {
  const AddTeachersEvent();
}

class InitializeDatabase extends AddTeachersEvent {
  const InitializeDatabase();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnAddClicked extends AddTeachersEvent {
  const OnAddClicked();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnClassClicked extends AddTeachersEvent {
  const OnClassClicked();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnNameFieldChanged extends AddTeachersEvent {
  final String name;

  const OnNameFieldChanged(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class OnAgeFieldChanged extends AddTeachersEvent {
  final String age;

  const OnAgeFieldChanged(this.age);

  @override
  // TODO: implement props
  List<Object?> get props => [age];
}

class OnClassFieldChanged extends AddTeachersEvent {
  final List<String> classLevel;

  const OnClassFieldChanged(this.classLevel);

  @override
  // TODO: implement props
  List<Object?> get props => [classLevel];
}

class OnDateOfBirthFieldChanged extends AddTeachersEvent {
  final String birthday;

  const OnDateOfBirthFieldChanged(this.birthday);

  @override
  // TODO: implement props
  List<Object?> get props => [birthday];
}

class OnFamilyNameFieldChanged extends AddTeachersEvent {
  final String familyName;

  const OnFamilyNameFieldChanged(this.familyName);

  @override
  // TODO: implement props
  List<Object?> get props => [familyName];
}
