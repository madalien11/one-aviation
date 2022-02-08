// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_flight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateFlightModel _$CreateFlightModelFromJson(Map<String, dynamic> json) {
  return CreateFlightModel(
    dateFrom: DateTime.parse(json['departure_time'] as String),
    dateTo: json['return_time'] == null
        ? null
        : DateTime.parse(json['return_time'] as String),
    document: json['document'] == null
        ? null
        : DocumentModel.fromJson(json['document'] as Map<String, dynamic>),
    email: json['email'] as String?,
    locationFrom:
        LocationCoordsModel.fromJson(json['from'] as Map<String, dynamic>),
    locationTo:
        LocationCoordsModel.fromJson(json['to'] as Map<String, dynamic>),
    phoneNumber: json['phone_number'] as String?,
    shareable: json['shareable'] as bool,
    passengers: (json['passengers'] as List<dynamic>?)
        ?.map((e) => PassengerModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CreateFlightModelToJson(CreateFlightModel instance) =>
    <String, dynamic>{
      'departure_time': instance.dateFrom.toIso8601String(),
      'return_time': instance.dateTo?.toIso8601String(),
      'from': instance.locationFrom,
      'to': instance.locationTo,
      'document': instance.document,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'shareable': instance.shareable,
      'passengers': instance.passengers,
    };
