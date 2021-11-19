// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_flight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchFlightModel _$SearchFlightModelFromJson(Map<String, dynamic> json) {
  return SearchFlightModel(
    dateFrom: DateTime.parse(json['date_from'] as String),
    dateTo: json['date_to'] == null
        ? null
        : DateTime.parse(json['date_to'] as String),
    locationFrom: LocationCoordsModel.fromJson(
        json['location_from'] as Map<String, dynamic>),
    locationTo: LocationCoordsModel.fromJson(
        json['location_to'] as Map<String, dynamic>),
    numberOfPassengers: json['number_of_passengers'] as int,
  );
}

Map<String, dynamic> _$SearchFlightModelToJson(SearchFlightModel instance) =>
    <String, dynamic>{
      'date_from': instance.dateFrom.toIso8601String(),
      'date_to': instance.dateTo?.toIso8601String(),
      'location_from': instance.locationFrom,
      'location_to': instance.locationTo,
      'number_of_passengers': instance.numberOfPassengers,
    };
