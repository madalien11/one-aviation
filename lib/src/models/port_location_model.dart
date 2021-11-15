import 'package:json_annotation/json_annotation.dart';

part 'port_location_model.g.dart';

@JsonSerializable()
class PortLocaitonModel {
  PortLocaitonModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final double latitude;
  // @JsonKey(name: 'longitude')
  final double longitude;

  factory PortLocaitonModel.fromJson(Map<String, dynamic> json) =>
      _$PortLocaitonModelFromJson(json);
  Map<String, dynamic> toJson() => _$PortLocaitonModelToJson(this);
}
