// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassengerModel _$PassengerModelFromJson(Map<String, dynamic> json) {
  return PassengerModel(
    document: DocumentModel.fromJson(json['document'] as Map<String, dynamic>),
    email: json['email'] as String,
    phoneNumber: json['phone_number'] as String,
    direction: json['direction'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    middleName: json['middle_name'] as String?,
  );
}

Map<String, dynamic> _$PassengerModelToJson(PassengerModel instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'document': instance.document,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'middle_name': instance.middleName,
      'phone_number': instance.phoneNumber,
    };
