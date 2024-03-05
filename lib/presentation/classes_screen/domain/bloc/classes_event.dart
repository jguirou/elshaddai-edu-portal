part of 'classes_bloc.dart';

abstract class ClassesEvent extends Equatable {
  const ClassesEvent();
}

class InitializeDatabase extends ClassesEvent {
  const InitializeDatabase();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnAddClicked extends ClassesEvent {
  const OnAddClicked();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnClassClicked extends ClassesEvent {
  const OnClassClicked();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnNameFieldChanged extends ClassesEvent {
  final String name;

  const OnNameFieldChanged(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class OnFatherNameFieldChanged extends ClassesEvent {
  final String name;

  const OnFatherNameFieldChanged(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class OnMotherNameFieldChanged extends ClassesEvent {
  final String name;

  const OnMotherNameFieldChanged(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class OnMotherFamilyNameFieldChanged extends ClassesEvent {
  final String name;

  const OnMotherFamilyNameFieldChanged(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class OnAgeFieldChanged extends ClassesEvent {
  final String age;

  const OnAgeFieldChanged(this.age);

  @override
  // TODO: implement props
  List<Object?> get props => [age];
}

class OnDateOfBirthFieldChanged extends ClassesEvent {
  final String birthday;

  const OnDateOfBirthFieldChanged(this.birthday);

  @override
  // TODO: implement props
  List<Object?> get props => [birthday];
}

class OnClassFieldChanged extends ClassesEvent {
  final String classLevel;

  const OnClassFieldChanged(this.classLevel);

  @override
  // TODO: implement props
  List<Object?> get props => [classLevel];
}

class OnFamilyNameFieldChanged extends ClassesEvent {
  final String familyName;

  const OnFamilyNameFieldChanged(this.familyName);

  @override
  // TODO: implement props
  List<Object?> get props => [familyName];
}
