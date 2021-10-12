import 'package:dio/dio.dart';
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
      return {'message': response.data.toString(), 'successful': true};
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
      return {'message': response.data.toString(), 'successful': true};
    } on DioError catch (e) {
      // Handle error
      return {
        'message': e.response!.data['error'].toString(),
        'successful': false
      };
    }
  }
}
