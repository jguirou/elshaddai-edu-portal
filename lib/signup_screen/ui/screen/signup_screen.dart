import 'package:el_shaddai_edu_portal/repositories/admin_repository/admin_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../login_screen/ui/screen/login_screen.dart';
import '../../domain/bloc/signup_bloc.dart';
import '../widgets/form_container_widget.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:  (context) => SignupBloc(),
            child: BlocConsumer<SignupBloc, SignupState>(
              builder: (BuildContext context, SignupState state) {
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Text("SignUp"),
                  ),
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FormContainerWidget(
                            hintText: "Username",
                            isPasswordField: false,
                            onFieldValueChanged: (val){
                              context.read<SignupBloc>().add(OnEmailFieldChanged(val));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormContainerWidget(
                            hintText: "Email",
                            isPasswordField: false,
                            onFieldValueChanged: (val){
                              context.read<SignupBloc>().add(OnEmailFieldChanged(val));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormContainerWidget(
                            hintText: "Password",
                            isPasswordField: true,
                            onFieldValueChanged: (val){
                              context.read<SignupBloc>().add(OnPasswordFieldChanged(val));
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap:  (){
                              //_signUp();
                              context.read<SignupBloc>().add(OnSignUpClicked());
                              Navigator.pushNamed(context, "/home");

                            },
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: state.isLoading ? CircularProgressIndicator(color: Colors.white,):Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const LoginScreen()),
                                            (route) => false);
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.blue, fontWeight: FontWeight.bold),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              listener: (BuildContext context, SignupState state) {  },


            ),



    );
  }
}
