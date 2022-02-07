// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    id: json['id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    middleName: json['middle_name'] as String?,
    birthDate: DateTime.parse(json['birth_date'] as String),
    phoneNumber: json['phone_number'] as String,
    email: json['email'] as String,
    document: json['document'] == null
        ? null
        : DocumentModel.fromJson(json['document'] as Map<String, dynamic>),
    isActive: json['is_active'] as bool,
    isAdmin: json['is_admin'] as bool,
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'middle_name': instance.middleName,
      'birth_date': instance.birthDate.toIso8601String(),
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'document': instance.document,
      'is_admin': instance.isAdmin,
      'is_active': instance.isActive,
    };
