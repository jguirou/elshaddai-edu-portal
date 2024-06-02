import 'package:el_shaddai_edu_portal/utils/constants/colors.dart';
import 'package:el_shaddai_edu_portal/utils/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/my_alert_dialog.dart';
import '../../../../../domain/repositories/admin_repository/admin_repository.dart';
import '../../../../../utils/constants/routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../home/registration/add_students/ui/widgets/my_card_container.dart';
import '../../domain/bloc/login_bloc.dart';
import '../widgets/login_form.dart';
import '../widgets/logo_box.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
                  colors: [Colors.blue, AppColors.white],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyCardContainer(
                          children: [
                            Text(AppTexts.schoolName,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(
                                      fontFamily: AppFonts.sacramentoRegular,
                                    )),
                            const LogoBox(),
                            const Divider(
                              indent: 8.0,
                              endIndent: 8.0,
                            ),
                            Text(
                                textAlign: TextAlign.center,
                                AppTexts.administration.toUpperCase(),
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(height: AppSizes.spaceBtwSections),
                            LoginForm(
                              mailController: mailController,
                              passwordController: passwordController,
                              obscureText: state.obscureText,
                              onHashPassword: () => context
                                  .read<LoginBloc>()
                                  .add(const OnObscureTextClicked()),
                              onLoginPressed: () => context
                                  .read<LoginBloc>()
                                  .add(OnLoginClicked(
                                      mailController.text.trim(),
                                      passwordController.text.trim())),
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
          if (state.loginStatus == FirebaseAuthError.noError.name ||
              state.loginStatus.isEmpty) {
            Navigator.pushNamed(context, Routes.home);
          } else {
            MyAlertDialog.errorAlertDialog(
                context: context,
                title: AppTexts.error,
                message: state.loginStatus);
            context.read<LoginBloc>().add(const OnResetLoginStatus());
          }
        },
      ),
    );
  }
}
