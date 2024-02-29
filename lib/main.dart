import 'package:el_shaddai_edu_portal/add_students_screen/ui/screen/add_students_screen.dart';
import 'package:el_shaddai_edu_portal/login_screen/domain/login_bloc.dart';
import 'package:el_shaddai_edu_portal/login_screen/ui/screen/login_screen.dart';
import 'package:el_shaddai_edu_portal/repositories/admin_repository/admin_repository.dart';
import 'package:el_shaddai_edu_portal/routes/routes.dart';
import 'package:el_shaddai_edu_portal/school_fees_screen/ui/screen/school_fees_screen.dart';
import 'package:el_shaddai_edu_portal/signup_screen/ui/screen/signup_screen.dart';
import 'package:el_shaddai_edu_portal/students_screen/ui/screen/students_screen.dart';
import 'package:el_shaddai_edu_portal/teachers_screen/ui/screen/teachers_screen.dart';
import 'package:el_shaddai_edu_portal/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_config/firebase_config.dart';
import 'home_screen/ui/screen/home_screen.dart'; // Import Firebase Auth


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        databaseURL: FirebaseConfig.databaseURL,
        apiKey: FirebaseConfig.apiKey,
        appId: FirebaseConfig.appId,
        messagingSenderId: FirebaseConfig.messagingSenderId,
        projectId: FirebaseConfig.projectId,
        // Your web Firebase config options

      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AdminRepository>(
            create: (context) => AdminRepository(), // You should replace this with your actual repository creation logic
          ),
        ],
        child: BlocProvider(
          create: (context) => LoginBloc(
          ),
          child: const LoginScreen(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'El Shaddai Edu Portal',
      routes: {
        Routes.login: (context) => const LoginScreen(),
        Routes.signUp: (context) => const SignUpScreen(),
        Routes.home: (context) => const HomeScreen(title: "Complexe Scolaire ElShaddai"),
        Routes.addStudents: (context) => AddStudentsScreen(onAddClicked: () {}, onCancelClicked: () {}),
        Routes.teachers: (context) => const TeachersScreen(),
        Routes.students: (context) => const StudentsScreen(),
        Routes.schoolFees: (context) => const SchoolFeesScreen(),

      },
    );
  }
}


