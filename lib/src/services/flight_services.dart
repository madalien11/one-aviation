import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_aviation/src/common/dio/my_dio.dart';
import 'package:one_aviation/src/models/create_flight/create_flight_model.dart';
import 'package:one_aviation/src/models/join_flight/join_flight_model.dart';
import 'package:one_aviation/src/models/search_flight/found_flight_model.dart';
import 'package:one_aviation/src/models/search_flight/search_flight_model.dart';

abstract class FlightServices {
  Future<Map<List<FoundFlightModel>?, String>?> searchFlights(
    SearchFlightModel? searchDetails,
  );

  Future<Map<String, dynamic>> joinFlight(JoinFlightModel passengersData);

  Future<Map<String, dynamic>> createFlight(CreateFlightModel flightData);

  Future<Map<List<FoundFlightModel>?, String>?> getMyHistory();
}

class FlightImplServices implements FlightServices {
  FlightImplServices({required MyDio myDio}) {
    myDio.path = '/';
    dio = myDio.dio;
  }
  late Dio dio;

  @override
  Future<Map<List<FoundFlightModel>?, String>?> searchFlights(
    SearchFlightModel? searchDetails,
  ) async {
    try {
      var response = searchDetails != null
          ? await dio.post(
              'order/sharing',
              data: searchDetails.toJson(),
            )
          : await dio.post('order/sharing');
      if (response.data != null) {
        var responseList = response.data!['flights'] as List?;
        if (responseList != null) {
          var result =
              responseList.map((e) => FoundFlightModel.fromJson(e)).toList();
          return {result: ''};
        } else {
          return {null: 'No flights were found'};
        }
      }
    } on DioError catch (e) {
      // Handle error
      print(e.message);
      return {null: e.message};
    }
  }

  @override
  Future<Map<String, dynamic>> joinFlight(
      JoinFlightModel passengersData) async {
    try {
      var response = await dio.post(
        'order/join',
        data: passengersData.toJson(),
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

  @override
  Future<Map<List<FoundFlightModel>?, String>?> getMyHistory() async {
    try {
      var box = Hive.box('tokens');
      dio.options.headers['Authorization'] = 'Bearer ${box.get('access')}';
      var response = await dio.get('order/history');
      var responseList = response.data!['flights'] as List?;
      if (responseList != null) {
        var result =
            responseList.map((e) => FoundFlightModel.fromJson(e)).toList();

        return {result: ''};
      } else {
        return {null: 'No flights were found'};
      }
    } on DioError catch (e) {
      // Handle error
      print(e.message);
      return {null: e.message};
    }
  }

  @override
  Future<Map<String, dynamic>> createFlight(
      CreateFlightModel flightData) async {
    try {
      var box = Hive.box('tokens');
      dio.options.headers['Authorization'] = 'Bearer ${box.get('access')}';
      var response = await dio.post('order', data: flightData.toJson());
      return {'message': response.data, 'successful': true};
    } on DioError catch (e) {
      // Handle error
      print(e.response);
      return {
        'message': e.response!.data['error'].toString(),
        'successful': false
      };
    }
  }
}
