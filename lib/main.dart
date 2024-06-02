import 'package:el_shaddai_edu_portal/presentation/authentication/login/domain/bloc/login_bloc.dart';
import 'package:el_shaddai_edu_portal/presentation/authentication/login/ui/screen/login_screen.dart';

import 'package:el_shaddai_edu_portal/utils/constants/routes.dart';
import 'package:el_shaddai_edu_portal/utils/constants/texts.dart';
import 'package:el_shaddai_edu_portal/utils/themes/themes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/repositories/admin_repository/admin_repository.dart';
import 'firebase_config/firebase_config.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
// Import Firebase Auth

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.load();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('fr', 'FR'),
      supportedLocales: const [
        Locale('en', 'En'), // English
        Locale('fr', 'FR'), // French
        // Add more supported locales as needed
      ], // Default locale
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AdminRepository>(
            create: (context) => AdminRepository(),
          ),
        ],
        child: BlocProvider(
          create: (context) => LoginBloc(),
          child: const LoginScreen(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: AppTexts.appName,
      routes: routes,
    );
  }
}
