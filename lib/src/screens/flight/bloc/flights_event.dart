part of 'flights_bloc.dart';

@immutable
abstract class FlightsEvent {}

class SearchFlights extends FlightsEvent {
  SearchFlights({required this.searchFlightData});
  final SearchFlightModel searchFlightData;
}

class JoinFlight extends FlightsEvent {
  JoinFlight({required this.passengersData});
  final JoinFlightModel passengersData;
}
