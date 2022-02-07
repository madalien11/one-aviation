import 'package:json_annotation/json_annotation.dart';
import 'package:one_aviation/src/models/document/document_model.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.birthDate,
    required this.phoneNumber,
    required this.email,
    required this.document,
    required this.isActive,
    required this.isAdmin,
  });

  final String id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @JsonKey(name: 'birth_date')
  final DateTime birthDate;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String email;
  final DocumentModel? document;
  @JsonKey(name: 'is_admin')
  final bool isAdmin;
  @JsonKey(name: 'is_active')
  final bool isActive;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
