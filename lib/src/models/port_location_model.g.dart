// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'port_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortLocaitonModel _$PortLocaitonModelFromJson(Map<String, dynamic> json) {
  return PortLocaitonModel(
    id: json['id'] as String,
    name: json['name'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$PortLocaitonModelToJson(PortLocaitonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
