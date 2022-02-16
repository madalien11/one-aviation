import 'package:json_annotation/json_annotation.dart';
import 'package:one_aviation/src/models/location_coords_model.dart';

part 'found_flight_model.g.dart';

@JsonSerializable()
class FoundFlightModel {
  FoundFlightModel({
    required this.id,
    required this.departureTime,
    required this.arrivalTime,
    this.availableSeats,
    required this.price,
    required this.from,
    required this.to,
    required this.status,
  });

  @JsonKey(name: 'arrival_time')
  final DateTime arrivalTime;
  @JsonKey(name: 'available_seats')
  final int? availableSeats;
  @JsonKey(name: 'departure_time')
  final DateTime departureTime;
  final LocationCoordsModel from;
  final int id;
  final String price;
  final String status;
  final LocationCoordsModel to;

  factory FoundFlightModel.fromJson(Map<String, dynamic> json) =>
      _$FoundFlightModelFromJson(json);
  Map<String, dynamic> toJson() => _$FoundFlightModelToJson(this);
}
