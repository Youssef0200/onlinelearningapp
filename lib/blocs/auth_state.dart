import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
class AuthCheckboxState extends AuthState {
  final bool isChecked;

  AuthCheckboxState(this.isChecked);
}
class AuthPasswordVisibilityState extends AuthState {
  final bool isPasswordVisible;

  AuthPasswordVisibilityState(this.isPasswordVisible);
}