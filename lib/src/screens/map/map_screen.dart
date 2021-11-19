import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_aviation/src/models/ports/port_location_model.dart';

import 'bloc/location_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Map<String, Marker> _markers = {};
  List<PortLocaitonModel> portLocations = [];
  bool _isLoading = true;
  bool _showError = false;
  String _errorMessage = 'Error!';

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      for (final port in portLocations) {
        final marker = Marker(
          markerId: MarkerId(port.name),
          position: LatLng(port.latitude, port.longitude),
          infoWindow: InfoWindow(
            title: port.name,
            // snippet: port.address,
            onTap: () {
              Navigator.pop(context, port);
            },
          ),
        );
        _markers[port.name] = marker;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(GetPortLocations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a location')),
      body: BlocListener<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationLoading) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);
          }

          if (state is LocationSuccessful) {
            setState(() {
              portLocations.clear();
              portLocations = state.ports;
            });
          } else if (state is LocationUnsuccessful) {
            setState(() => _errorMessage = state.errorMessage);
          }
        },
        child: _isLoading
            ? Center(child: CupertinoActivityIndicator())
            : _showError
                ? Center(child: Text(_errorMessage))
                : Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(41, 2),
                        zoom: 5,
                      ),
                      markers: _markers.values.toSet(),
                    ),
                  ),
      ),
    );
  }
}
