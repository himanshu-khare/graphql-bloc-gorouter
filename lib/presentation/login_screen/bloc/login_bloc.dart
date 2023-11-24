import 'package:flutter/material.dart';
import '/core/app_export.dart';
part 'login_state.dart';

/// A bloc that manages the state of a Login according to the event that is dispatched to it.
class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginInitialState());

  final emailController=TextEditingController();

  final passwordController=TextEditingController();
  bool? visiblity;

}
