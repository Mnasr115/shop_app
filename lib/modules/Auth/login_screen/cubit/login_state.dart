part of 'login_cubit.dart';

@immutable
abstract class LoginStates {}

class LoginInitialState extends LoginStates {}
class LoginSuccessState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginErrorState extends LoginStates {
  final String errorMessage;

  LoginErrorState(this.errorMessage);
}
class ChangePasswordVisibilityState extends LoginStates {}
