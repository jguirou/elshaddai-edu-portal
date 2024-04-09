part of 'teachers_bloc.dart';

class TeachersState extends Equatable {
  final bool isLoading;
  final List<Teachers> teachersList;

  final DatabaseReference? databaseReference;
  final DatabaseReference? teachersReference;

  const TeachersState({
    this.isLoading = false,
    this.teachersList = const [],
    this.databaseReference,
    this.teachersReference,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isLoading, teachersList, databaseReference, teachersReference];

  TeachersState copyWith({
    bool? isLoading,
    List<Teachers>? teachersList,
    DatabaseReference? databaseReference,
    DatabaseReference? teachersReference,
  }) {
    return TeachersState(
      isLoading: isLoading ?? this.isLoading,
      teachersList: teachersList ?? this.teachersList,
      databaseReference: databaseReference ?? this.databaseReference,
      teachersReference: teachersReference ?? this.teachersReference,
    );
  }
}
