import 'package:go_router/go_router.dart';
import 'package:servicesapp/main.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/widgets/custom_elevated_button.dart';
import 'package:servicesapp/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context, GoRouterState state) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(), child: LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appTheme.green,
      body: Form(
          key: _formKey,
          child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 24.h,
                right: 24.h,
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Spacer(),
                Text("lbl_sign_in".tr,
                    style: theme.textTheme.labelMedium?.copyWith(fontSize: 28)),
                SizedBox(height: 31.v),
                _buildUsername(context),
                SizedBox(height: 16.v),
                _buildPassword(context),
                SizedBox(height: 24.v),
                _buildSignIn(context),
                Spacer(),
              ]))),
    );
  }

  /// Section Widget
  Widget _buildUsername(BuildContext context) {
     final bloc = context.read<LoginBloc>();
          final username = bloc.emailController;
          return CustomTextFormField(
            controller: username,
            hintText: "lbl_username".tr,
            textStyle: TextStyle(color: appTheme.black),
            fillColor: appTheme.white,
            hintStyle: TextStyle(color: appTheme.black),
            textInputType: TextInputType.name,
          );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
     final cubit = context.read<LoginBloc>();
      return StatefulBuilder(
        builder: (context, snapshot) {
          return CustomTextFormField(
                    controller: cubit.passwordController,
                    fillColor: appTheme.white,
                    hintStyle: TextStyle(color: appTheme.black),
                    hintText: "lbl_password".tr,
                    textStyle: TextStyle(color: appTheme.black),
                    suffix: cubit.visiblity == true
                        ? Icon(Icons.visibility).onInkTap(() {
                           cubit.visiblity = false;
                            snapshot(() {});
                          })
                        : Icon(Icons.visibility_off).onInkTap(() {
                            cubit.visiblity = true;
                            snapshot(() {});
                          }),
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: cubit.visiblity == true ? false : true);
        }
      );
  }

  Widget _buildSignIn(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_sign_in2".tr,
        onPressed: () {
          final bloc = context.read<LoginBloc>();
          final username = bloc.emailController.text;
          if (username.isEmpty) {
            globalMessengerKey.currentState
                ?.showSnackBar(SnackBar(content: Text("Username is required")));
            return;
          }
          context.go(AppRoutes.homePageScreen, extra: username);
        },
        buttonStyle: CustomButtonStyles.fillOnPrimaryContainer,
          buttonTextStyle: TextStyle(color: appTheme.black));
  }
}
