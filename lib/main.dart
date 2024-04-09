import 'package:el_shaddai_edu_portal/presentation/login_screen/domain/bloc/login_bloc.dart';
import 'package:el_shaddai_edu_portal/presentation/login_screen/ui/screen/login_screen.dart';
import 'package:el_shaddai_edu_portal/routes/routes.dart';

import 'package:el_shaddai_edu_portal/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'domain/repositories/admin_repository/admin_repository.dart';
import 'firebase_config/firebase_config.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'En'), // English
            Locale('fr', 'FR'), // French
            // Add more supported locales as needed
          ],
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
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
          title: 'El Shaddai Edu Portal',
          routes: routes,
        );
      },
    );
  }
}
