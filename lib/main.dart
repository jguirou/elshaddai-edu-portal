import 'package:el_shaddai_edu_portal/add_students_screen/ui/screen/add_students_screen.dart';
import 'package:el_shaddai_edu_portal/login_screen/domain/login_bloc.dart';
import 'package:el_shaddai_edu_portal/login_screen/ui/screen/login_screen.dart';
import 'package:el_shaddai_edu_portal/repositories/admin_repository/admin_repository.dart';
import 'package:el_shaddai_edu_portal/signup_screen/ui/screen/signup_screen.dart';
import 'package:el_shaddai_edu_portal/students_screen/ui/screen/students_screen.dart';
import 'package:el_shaddai_edu_portal/teachers_screen/ui/screen/teachers_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen/ui/screen/home_screen.dart'; // Import Firebase Auth


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        databaseURL: 'https://el-shaddai-edu-portal-default-rtdb.firebaseio.com/',
        apiKey: "AIzaSyCDkrG8RNJd7c1k2Sr2EJ72ntNoxdK1xBk",
        appId: "1:456559092854:web:3d4d1aee25bc54c13a6b57",
        messagingSenderId: "456559092854",
        projectId: "el-shaddai-edu-portal",
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
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AdminRepository>(
            create: (context) => AdminRepository(), // You should replace this with your actual repository creation logic
          ),
        ],
        child: BlocProvider(
          create: (context) => LoginBloc(
          ),
          child: LoginScreen(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'ElSaddaiEduPortal',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/home': (context) => const HomeScreen(title:"Complexe Scolaire ElShaddai"),
        '/add_students': (context) => AddStudentsScreen(onAddClicked: (){}, onCancelClicked: (){},),
        '/teachers': (context) => const TeachersScreen(),
        '/students': (context) => const StudentsScreen(),

      },
    );
  }
}


