import 'package:json_annotation/json_annotation.dart';

part 'location_coords_model.g.dart';

@JsonSerializable()
class LocationCoordsModel {
  LocationCoordsModel({
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  final double latitude;
  final double longitude;
  final String name;

  factory LocationCoordsModel.fromJson(Map<String, dynamic> json) =>
      _$LocationCoordsModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationCoordsModelToJson(this);
}
