part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccessful extends LocationState {
  LocationSuccessful({required this.ports});
  final List<PortLocaitonModel> ports;
}

class LocationUnsuccessful extends LocationState {
  LocationUnsuccessful({required this.errorMessage});
  final String errorMessage;
}
