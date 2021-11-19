// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_coords_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationCoordsModel _$LocationCoordsModelFromJson(Map<String, dynamic> json) {
  return LocationCoordsModel(
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LocationCoordsModelToJson(
        LocationCoordsModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
