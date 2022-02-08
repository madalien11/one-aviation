import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_aviation/src/common/dio/my_dio.dart';

abstract class AuthorizationService {
  Future<Map<String, dynamic>> register({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required bool isMale,
  });

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> resetPasswordVerify({
    required String email,
  });

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> verifyEmail({
    required String email,
  });
}

class AuthorizationImplService implements AuthorizationService {
  AuthorizationImplService({required MyDio myDio}) {
    myDio.path = 'auth/';
    dio = myDio.dio;
  }
  late Dio dio;

  @override
  Future<Map<String, dynamic>> register({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required bool isMale,
  }) async {
    try {
      var response = await dio.post('register', data: {
        'email': email,
        "first_name": firstName,
        "last_name": lastName,
        'password': password,
        "phone_number": phoneNumber,
        "sex": isMale ? "male" : "female",
      });
      return {'message': response.data, 'successful': true};
    } on DioError catch (e) {
      // Handle error
      return {
        'message': e.response!.data['error'].toString(),
        'successful': false
      };
    }
  }

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await dio.post('login', data: {
        'email': email,
        'password': password,
      });
      return {'message': response.data, 'successful': true};
    } on DioError catch (e) {
      // Handle error
      return {
        'message': e.response!.data['error'].toString(),
        'successful': false
      };
    }
  }

  @override
  Future<Map<String, dynamic>> resetPasswordVerify({
    required String email,
  }) async {
    try {
      var response = await dio.put(
        'reset/password/verify',
        queryParameters: {'email': email},
      );
      var box = Hive.box('tokens');
      await box.put('reset_token', response.data['token']);
      await box.put('otp', response.data['otp']);
      return {'message': response.data, 'successful': true};
    } on DioError catch (e) {
      // Handle error
      return {
        'message': e.response!.data['error'].toString(),
        'successful': false
      };
    }
  }

  @override
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      var box = Hive.box('tokens');
      dio.options.headers['Authorization'] = 'Bearer ${box.get('reset_token')}';

      var response = await dio.put('reset/password', data: {
        'email': email,
        'password': password,
      });
      return {'message': response.data, 'successful': true};
    } on DioError catch (e) {
      // Handle error
      return {
        'message': e.response!.data['error'].toString(),
        'successful': false
      };
    }
  }

  @override
  Future<Map<String, dynamic>> verifyEmail({
    required String email,
  }) async {
    try {
      var response = await dio.put(
        'verify/email',
        queryParameters: {'email': email},
      );

      return {'message': response.data, 'successful': true};
    } on DioError catch (e) {
      // Handle error
      return {
        'message': e.response!.data['error'].toString(),
        'successful': false
      };
    }
  }
}
