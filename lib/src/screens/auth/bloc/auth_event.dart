part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Login extends AuthEvent {
  Login({required this.email, required this.password});
  final String email;
  final String password;
}

class Register extends AuthEvent {
  Register({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.isMale,
  });
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String phoneNumber;
  final bool isMale;
}
