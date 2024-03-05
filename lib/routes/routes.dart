import 'package:flutter/material.dart';

import '../presentation/add_students_screen/ui/screen/add_students_screen.dart';
import '../presentation/home_screen/ui/screen/home_screen.dart';
import '../presentation/login_screen/ui/screen/login_screen.dart';
import '../presentation/school_fees_screen/ui/screen/school_fees_screen.dart';
import '../presentation/signup_screen/ui/screen/signup_screen.dart';
import '../presentation/students_screen/ui/screen/students_screen.dart';
import '../presentation/teachers_screen/ui/screen/teachers_screen.dart';

class Routes {
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String addStudents = '/add_students';
  static const String teachers = '/teachers';
  static const String students = '/students';
  static const String schoolFees = '/school_fees';
}

Map<String, WidgetBuilder> routes = {
  Routes.login: (context) => const LoginScreen(),
  Routes.signUp: (context) => const SignUpScreen(),
  Routes.home: (context) =>
      const HomeScreen(title: "Complexe Scolaire ElShaddai"),
  Routes.addStudents: (context) =>
      AddStudentsScreen(onAddClicked: () {}, onCancelClicked: () {}),
  Routes.teachers: (context) => const TeachersScreen(),
  Routes.students: (context) => const StudentsScreen(),
  Routes.schoolFees: (context) => const SchoolFeesScreen(),
};
