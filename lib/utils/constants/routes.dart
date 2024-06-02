import 'package:flutter/material.dart';

import '../../presentation/authentication/login/ui/screen/login_screen.dart';
import '../../presentation/home/home/ui/screen/home_screen.dart';
import '../../presentation/home/registration/add_students/ui/screen/add_students_screen.dart';
import '../../presentation/home/school_fees/ui/screen/school_fees_screen.dart';
import '../../presentation/home/students/ui/screen/students_screen.dart';
import '../../presentation/home/teachers/ui/screen/teachers_screen.dart';
import 'texts.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String addStudents = '/add_students';
  static const String teachers = '/teachers';
  static const String students = '/students';
  static const String schoolFees = '/school_fees';
}

Map<String, WidgetBuilder> routes = {
  Routes.login: (context) => const LoginScreen(),
  Routes.home: (context) =>
       const HomeScreen(title: AppTexts.schoolName),
  Routes.addStudents: (context) =>
      const AddStudentsScreen(),
  Routes.teachers: (context) => const TeachersScreen(),
  Routes.students: (context) => const StudentsScreen(),
  Routes.schoolFees: (context) => const SchoolFeesScreen(),
};
