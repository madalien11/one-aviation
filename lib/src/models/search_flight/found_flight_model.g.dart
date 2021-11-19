// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'found_flight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoundFlightModel _$FoundFlightModelFromJson(Map<String, dynamic> json) {
  return FoundFlightModel(
    id: json['id'] as int,
    departureTime: DateTime.parse(json['departure_time'] as String),
    arrivalTime: DateTime.parse(json['arrival_time'] as String),
    availableSeats: json['available_seats'] as int,
    price: json['price'] as String,
    from: LocationCoordsModel.fromJson(json['from'] as Map<String, dynamic>),
    to: LocationCoordsModel.fromJson(json['to'] as Map<String, dynamic>),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$FoundFlightModelToJson(FoundFlightModel instance) =>
    <String, dynamic>{
      'arrival_time': instance.arrivalTime.toIso8601String(),
      'available_seats': instance.availableSeats,
      'departure_time': instance.departureTime.toIso8601String(),
      'from': instance.from,
      'id': instance.id,
      'price': instance.price,
      'status': instance.status,
      'to': instance.to,
    };
