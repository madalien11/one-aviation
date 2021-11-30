import 'dart:async';

import 'package:one_aviation/src/services/auth_services.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authServices}) : super(AuthInitial());
  final AuthorizationService authServices;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is Login) {
      yield LoginLoading();
      if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
        var res = await authServices.login(
          email: event.email.trim(),
          password: event.password.trim(),
        );
        if (res['successful']) {
          var box = Hive.box('tokens');
          await box.put('access', res['message']['access_token']);
          await box.put('refresh', res['message']['refresh_token']);
          yield LoginSuccessful();
        } else {
          yield LoginUnsuccessful(errorMessage: res['message']);
        }
      } else {
        yield LoginUnsuccessful(errorMessage: 'Заполните все поля');
      }
    } else if (event is Register) {
      yield RegistrationLoading();
      if (event.email.trim().isNotEmpty &&
          event.password.trim().isNotEmpty &&
          event.phoneNumber.trim().isNotEmpty) {
        var res = await authServices.register(
          email: event.email.trim(),
          firstName: event.firstName,
          lastName: event.lastName,
          password: event.password.trim(),
          phoneNumber: event.phoneNumber.trim(),
          isMale: event.isMale,
        );
        if (res['successful']) {
          yield RegistrationSuccessful();
        } else {
          yield RegistrationUnsuccessful(errorMessage: res['message']);
        }
      } else {
        yield RegistrationUnsuccessful(errorMessage: 'Заполните все поля');
      }
    } else if (event is VerifyEmail) {
      yield VerifyEmailLoading();
      if (event.email.trim().isNotEmpty) {
        var res = await authServices.verifyEmail(
          email: event.email.trim(),
        );
        if (res['successful']) {
          yield VerifyEmailSuccessful();
        } else {
          yield VerifyEmailUnsuccessful(errorMessage: res['message']);
        }
      } else {
        yield VerifyEmailUnsuccessful(errorMessage: 'Заполните все поля');
      }
    } else if (event is ResetPassword) {
      yield ResetPasswordLoading();
      if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
        var res = await authServices.resetPassword(
          email: event.email.trim(),
          password: event.password.trim(),
        );
        if (res['successful']) {
          yield ResetPasswordSuccessful();
        } else {
          yield ResetPasswordUnsuccessful(errorMessage: res['message']);
        }
      } else {
        yield ResetPasswordUnsuccessful(errorMessage: 'Заполните все поля');
      }
    }
  }
}
