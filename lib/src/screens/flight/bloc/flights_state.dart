part of 'flights_bloc.dart';

@immutable
abstract class FlightsState {}

class FlightsInitial extends FlightsState {}

class SearchFlightsLoading extends FlightsState {}

class SearchFlightsSuccessful extends FlightsState {
  SearchFlightsSuccessful({required this.foundFlights});
  final List<FoundFlightModel> foundFlights;
}

class SearchFlightsUnsuccessful extends FlightsState {
  SearchFlightsUnsuccessful({required this.errorMessage});
  final String errorMessage;
}

class JoinFlightLoading extends FlightsState {}

class JoinFlightSuccessful extends FlightsState {}

class JoinFlightUnsuccessful extends FlightsState {
  JoinFlightUnsuccessful({required this.errorMessage});
  final String errorMessage;
}

class MyHistoryLoading extends FlightsState {}

class MyHistorySuccessful extends FlightsState {
  MyHistorySuccessful({required this.myHistory});
  final dynamic myHistory;
}

class MyHistoryUnsuccessful extends FlightsState {
  MyHistoryUnsuccessful({required this.errorMessage});
  final String errorMessage;
}
