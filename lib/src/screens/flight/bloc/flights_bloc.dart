import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
    }
  }
}
