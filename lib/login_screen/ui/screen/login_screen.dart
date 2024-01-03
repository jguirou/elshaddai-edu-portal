import 'package:el_shaddai_edu_portal/add_students_screen/ui/widgets/my_card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/admin_repository/admin_repository.dart';
import '../../../signup_screen/ui/widgets/form_container_widget.dart';
import '../../domain/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          return Material(
            child: Container(
              //color: Colors.blue,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.white],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(

                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 100.0, right: 100.0 ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        MyCardContainer(
                          //topPadding: 50,
                          //bottomPadding: 100,
                          //leftPadding: 50,
                          //rightPadding: 50,
                          children: [
                            const Text(
                              'Complexe Scolaire El Shaddai',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Sacramento-Regular',
                                //fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 150,
                                maxWidth: 150,
                              ),
                              child: Image.asset(
                                'assets/images/school.png',
                              ),
                            ),
                            const Divider(
                              indent: 8.0,
                              endIndent: 8.0,
                            ),
                            const Text(
                              textAlign: TextAlign.center,
                              'ADMINISTRATION',
                              style: TextStyle(
                                //fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            FormContainerWidget(
                              hintText: "Email",
                              isPasswordField: false,
                              onFieldValueChanged: (val) {
                                context
                                    .read<LoginBloc>()
                                    .add(OnEmailFieldChanged(val));
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FormContainerWidget(
                              onFieldValueChanged: (val) {
                                context
                                    .read<LoginBloc>()
                                    .add(OnPasswordFieldChanged(val));
                              },
                              hintText: "Password",
                              isPasswordField: true,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                //_signIn();
                                context
                                    .read<LoginBloc>()
                                    .add(const OnLoginClicked());
                              },
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: state.isLoading
                                      ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                      : const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, LoginState state) {
          if (state.loginStatus == FirebaseAuthError.noError.name) {
            Navigator.pushNamed(context, "/home");
          } else if (state.loginStatus.isEmpty) {
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(getFirebaseAuthErrorMessage(state.loginStatus)),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
            context.read<LoginBloc>().add(const OnResetLoginStatus());
          }
        },
      ),
    );
  }
}

String getFirebaseAuthErrorMessage(String error) {
  switch (error) {
    case 'invalid-email':
      return "Invalid email address";
    case 'invalid-login-credentials':
      return "Invalid email address or wrong password";
    case 'user-not-found':
      return "User not found";
    case 'wrong-password':
      return "Incorrect password";
    case 'weak-password':
      return "Password is too weak";
    case 'email-already-in-use':
      return "Email is already in use";
    case 'operation-not-allowed':
      return "Operation not allowed";
    case 'user-disabled':
      return "User account is disabled";
    case 'too-many-requests':
      return "Too many login attempts. Try again later";
    case FirebaseAuthError.undefined:
      return "Undefined error";
    default:
      return error;
  }
}
