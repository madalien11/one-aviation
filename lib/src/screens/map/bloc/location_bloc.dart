import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:one_aviation/src/models/port_location_model.dart';
import 'package:one_aviation/src/services/location_services.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc({
    required this.locationService,
  }) : super(LocationInitial());
  final LocationService locationService;

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is GetPortLocations) {
      yield LocationLoading();
      var res = await locationService.getPorts();
      if (res != null && res.keys.first != null) {
        yield LocationSuccessful(ports: res.keys.first!);
      } else {
        yield LocationUnsuccessful(
          errorMessage: res == null ? 'Ports were not found' : res.values.first,
        );
      }
    }
  }
}
