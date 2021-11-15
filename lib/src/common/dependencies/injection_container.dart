import 'package:get_it/get_it.dart';
import 'package:one_aviation/src/common/dio/my_dio.dart';
import 'package:one_aviation/src/services/auth_services.dart';
import 'package:one_aviation/src/services/location_services.dart';

GetIt getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton<MyDio>(MyDio());

  getIt.registerSingleton<AuthorizationService>(
      AuthorizationImplService(myDio: getIt<MyDio>()));

  getIt.registerSingleton<LocationService>(
      LocationImplService(myDio: getIt<MyDio>()));
}
