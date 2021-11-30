import 'package:json_annotation/json_annotation.dart';
import 'package:one_aviation/src/models/document/document_model.dart';

part 'passenger_model.g.dart';

@JsonSerializable()
class PassengerModel {
  PassengerModel({
    required this.document,
    required this.email,
    required this.phoneNumber,
    required this.direction,
    required this.firstName,
    required this.lastName,
    this.middleName,
  });

  final String direction;
  final DocumentModel document;
  final String email;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  factory PassengerModel.fromJson(Map<String, dynamic> json) =>
      _$PassengerModelFromJson(json);
  Map<String, dynamic> toJson() => _$PassengerModelToJson(this);
}
