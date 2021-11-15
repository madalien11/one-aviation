import 'package:dio/dio.dart';
import 'package:one_aviation/src/common/dio/my_dio.dart';
import 'package:one_aviation/src/models/port_location_model.dart';

abstract class LocationService {
  Future<Map<List<PortLocaitonModel>?, String>?> getPorts();
}

class LocationImplService implements LocationService {
  LocationImplService({required MyDio myDio}) {
    myDio.path = '/';
    dio = myDio.dio;
  }
  late Dio dio;

  @override
  Future<Map<List<PortLocaitonModel>?, String>?> getPorts() async {
    try {
      var response = await dio.get('port');
      if (response.data != null) {
        var responseList = response.data!['ports'] as List;

        var result =
            responseList.map((e) => PortLocaitonModel.fromJson(e)).toList();
        return {result: ''};
      }
    } on DioError catch (e) {
      // Handle error
      print(e.message);
      return {null: e.message};
    }
  }
}
