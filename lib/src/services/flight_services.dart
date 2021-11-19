import 'package:dio/dio.dart';
import 'package:one_aviation/src/common/dio/my_dio.dart';
import 'package:one_aviation/src/models/search_flight/found_flight_model.dart';
import 'package:one_aviation/src/models/search_flight/search_flight_model.dart';

abstract class FlightServices {
  Future<Map<List<FoundFlightModel>?, String>?> searchFlights(
    SearchFlightModel searchDetails,
  );
}

class FlightImplServices implements FlightServices {
  FlightImplServices({required MyDio myDio}) {
    myDio.path = '/';
    dio = myDio.dio;
  }
  late Dio dio;

  @override
  Future<Map<List<FoundFlightModel>?, String>?> searchFlights(
    SearchFlightModel searchDetails,
  ) async {
    try {
      var response = await dio.post(
        'order/sharing',
        data: searchDetails.toJson(),
      );
      if (response.data != null) {
        var responseList = response.data!['flights'] as List;

        var result =
            responseList.map((e) => FoundFlightModel.fromJson(e)).toList();
        return {result: ''};
      }
    } on DioError catch (e) {
      // Handle error
      print(e.message);
      return {null: e.message};
    }
  }
}
