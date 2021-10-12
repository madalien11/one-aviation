part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginUnsuccessful extends AuthState {
  LoginUnsuccessful({required this.errorMessage});
  final String errorMessage;
}

class LoginSuccessful extends AuthState {}

class RegistrationLoading extends AuthState {}

class RegistrationUnsuccessful extends AuthState {
  RegistrationUnsuccessful({required this.errorMessage});
  final String errorMessage;
}

class RegistrationSuccessful extends AuthState {}
