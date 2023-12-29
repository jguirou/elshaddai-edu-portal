part of 'add_students_bloc.dart';

abstract class AddStudentsEvent extends Equatable {
  const AddStudentsEvent();
}

class InitializeDatabase extends AddStudentsEvent {
  const InitializeDatabase();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnAddClicked extends AddStudentsEvent {
  const OnAddClicked();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnClassClicked extends AddStudentsEvent {
  const OnClassClicked();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnNameFieldChanged extends AddStudentsEvent {
  final String name;

  const OnNameFieldChanged(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
class OnFatherNameFieldChanged extends AddStudentsEvent {
  final String name;

  const OnFatherNameFieldChanged(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
class OnMotherNameFieldChanged extends AddStudentsEvent {
  final String name;

  const OnMotherNameFieldChanged(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
class OnMotherFamilyNameFieldChanged extends AddStudentsEvent {
  final String name;

  const OnMotherFamilyNameFieldChanged(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class OnAgeFieldChanged extends AddStudentsEvent {
  final String age;

  const OnAgeFieldChanged(this.age);

  @override
  // TODO: implement props
  List<Object?> get props => [age];
}
class OnDateOfBirthFieldChanged extends AddStudentsEvent {
  final String birthday;

  const OnDateOfBirthFieldChanged(this.birthday);

  @override
  // TODO: implement props
  List<Object?> get props => [birthday];
}
class OnClassFieldChanged extends AddStudentsEvent {
  final String classLevel;

  const OnClassFieldChanged(this.classLevel);

  @override
  // TODO: implement props
  List<Object?> get props => [classLevel];
}

class OnFamilyNameFieldChanged extends AddStudentsEvent {
  final String familyName;

  const OnFamilyNameFieldChanged(this.familyName);

  @override
  // TODO: implement props
  List<Object?> get props => [familyName];
}
