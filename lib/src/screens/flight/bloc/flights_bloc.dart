import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:one_aviation/src/models/create_flight/create_flight_model.dart';
import 'package:one_aviation/src/models/join_flight/join_flight_model.dart';
import 'package:one_aviation/src/models/search_flight/found_flight_model.dart';
import 'package:one_aviation/src/models/search_flight/search_flight_model.dart';
import 'package:one_aviation/src/services/flight_services.dart';

part 'flights_event.dart';
part 'flights_state.dart';

class FlightsBloc extends Bloc<FlightsEvent, FlightsState> {
  FlightsBloc({
    required this.flightServices,
  }) : super(FlightsInitial());
  final FlightServices flightServices;

  @override
  Stream<FlightsState> mapEventToState(
    FlightsEvent event,
  ) async* {
    if (event is SearchFlights) {
      yield SearchFlightsLoading();
      var res = await flightServices.searchFlights(event.searchFlightData);
      if (res != null && res.keys.first != null) {
        yield SearchFlightsSuccessful(foundFlights: res.keys.first!);
      } else {
        yield SearchFlightsUnsuccessful(
          errorMessage:
              res == null ? 'Flights were not found' : res.values.first,
        );
      }
    } else if (event is JoinFlight) {
      yield JoinFlightLoading();
      var res = await flightServices.joinFlight(event.passengersData);
      if (res['successful']) {
        yield JoinFlightSuccessful();
      } else {
        yield JoinFlightUnsuccessful(errorMessage: res['message']);
      }
    } else if (event is GetMyHistory) {
      yield MyHistoryLoading();
      var res = await flightServices.getMyHistory();
      if (res['successful']) {
        yield MyHistorySuccessful(myHistory: res['message']);
      } else {
        yield MyHistoryUnsuccessful(errorMessage: res['message']);
      }
    } else if (event is CreateFlight) {
      yield CreateFlightLoading();
      var res = await flightServices.createFlight(event.flightData);
      if (res['successful']) {
        yield CreateFlightSuccessful();
      } else {
        yield CreateFlightUnsuccessful(errorMessage: res['message']);
      }
    }
  }
}
