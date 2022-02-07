import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_aviation/src/common/dio/my_dio.dart';
import 'package:one_aviation/src/models/profile/profile_model.dart';

abstract class ProfileService {
  Future<Map<String, dynamic>> getMyProfile();
}

class ProfileImplService implements ProfileService {
  ProfileImplService({required MyDio myDio}) {
    myDio.path = 'profile/';
    dio = myDio.dio;
  }
  late Dio dio;

  @override
  Future<Map<String, dynamic>> getMyProfile() async {
    try {
      var box = Hive.box('tokens');
      dio.options.headers['Authorization'] = 'Bearer ${box.get('access')}';
      var response = await dio.get('my');
      return {
        'message': ProfileModel.fromJson(response.data),
        'successful': true
      };
    } on DioError catch (e) {
      // Handle error
      return {
        'message': e.response!.data['error'].toString(),
        'successful': false
      };
    }
  }
}
