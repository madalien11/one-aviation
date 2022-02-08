part of 'flights_bloc.dart';

@immutable
abstract class FlightsEvent {}

class SearchFlights extends FlightsEvent {
  SearchFlights({this.searchFlightData});
  final SearchFlightModel? searchFlightData;
}

class JoinFlight extends FlightsEvent {
  JoinFlight({required this.passengersData});
  final JoinFlightModel passengersData;
}

class GetMyHistory extends FlightsEvent {}

class CreateFlight extends FlightsEvent {
  CreateFlight({required this.flightData});
  final CreateFlightModel flightData;
}
