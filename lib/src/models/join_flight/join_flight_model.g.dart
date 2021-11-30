// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_flight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinFlightModel _$JoinFlightModelFromJson(Map<String, dynamic> json) {
  return JoinFlightModel(
    document: DocumentModel.fromJson(json['document'] as Map<String, dynamic>),
    email: json['email'] as String,
    orderId: json['order_id'] as int,
    passengers: (json['passengers'] as List<dynamic>)
        .map((e) => PassengerModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    phoneNumber: json['phone_number'] as String,
  );
}

Map<String, dynamic> _$JoinFlightModelToJson(JoinFlightModel instance) =>
    <String, dynamic>{
      'document': instance.document,
      'email': instance.email,
      'order_id': instance.orderId,
      'passengers': instance.passengers,
      'phone_number': instance.phoneNumber,
    };
