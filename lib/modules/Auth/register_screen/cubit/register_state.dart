part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {
  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}
class RegisterErrorState extends RegisterState {
  final String errorMessage;

  RegisterErrorState(this.errorMessage);
}
class ChangeRegisterPasswordVisibilityState extends RegisterState {}


