import 'package:json_annotation/json_annotation.dart';
import 'package:one_aviation/src/models/location_coords_model.dart';

part 'search_flight_model.g.dart';

@JsonSerializable()
class SearchFlightModel {
  SearchFlightModel({
    required this.dateFrom,
    this.dateTo,
    required this.locationFrom,
    required this.locationTo,
    required this.numberOfPassengers,
  });

  @JsonKey(name: 'date_from')
  final DateTime dateFrom;
  @JsonKey(name: 'date_to')
  final DateTime? dateTo;
  @JsonKey(name: 'location_from')
  final LocationCoordsModel locationFrom;
  @JsonKey(name: 'location_to')
  final LocationCoordsModel locationTo;
  @JsonKey(name: 'number_of_passengers')
  final int numberOfPassengers;

  factory SearchFlightModel.fromJson(Map<String, dynamic> json) =>
      _$SearchFlightModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchFlightModelToJson(this);
}
