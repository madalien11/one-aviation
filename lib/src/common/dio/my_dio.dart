import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../config.dart';

class MyDio {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl))
    ..interceptors.add(DioInterceptor());

  set path(String path) => dio = Dio(BaseOptions(baseUrl: baseUrl + path))
    ..interceptors.add(DioInterceptor());
}

class DioInterceptor extends Interceptor {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
  var box = Hive.box('tokens');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // if (options.path.contains('products') &&
    //     box.get('access') != null &&
    //     !options.path.contains('name')) {
    //   // if (options.path.contains('products') && box.get('access') != null) {
    //   //   options.headers['Authorization'] = 'Bearer ${box.get('access')}';
    //   // } else {
    //   options.headers['Authorization'] = 'Bearer ${box.get('access')}';
    //   // }
    // }
    super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // if (err.response != null &&
    //     err.response!.statusCode == HttpStatus.unauthorized) {
    //   try {
    //     var response = await dio.post('auth/login/refresh/', data: {
    //       'refreshToken': box.get('refresh'),
    //     });

    //     await box.put('access', response.data['tokens']['accessToken']);
    //     await box.put('refresh', response.data['tokens']['refreshToken']);
    //   } on DioError {
    //     print(err.response);
    //     throw DioError;
    //   }
    // }
    super.onError(err, handler);
    return err;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}
