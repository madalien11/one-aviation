import 'package:json_annotation/json_annotation.dart';
import 'package:one_aviation/src/models/document/document_model.dart';
import 'package:one_aviation/src/models/location_coords_model.dart';
import 'package:one_aviation/src/models/passenger/passenger_model.dart';

part 'create_flight_model.g.dart';

@JsonSerializable()
class CreateFlightModel {
  CreateFlightModel({
    required this.dateFrom,
    this.dateTo,
    this.document,
    this.email,
    required this.locationFrom,
    required this.locationTo,
    this.phoneNumber,
    required this.shareable,
    required this.passengers,
  });

  @JsonKey(name: 'departure_time')
  final DateTime dateFrom;
  @JsonKey(name: 'return_time')
  final DateTime? dateTo;
  @JsonKey(name: 'from')
  final LocationCoordsModel locationFrom;
  @JsonKey(name: 'to')
  final LocationCoordsModel locationTo;
  late DocumentModel? document;
  late String? email;
  @JsonKey(name: 'phone_number')
  late String? phoneNumber;
  final bool shareable;
  late List<PassengerModel>? passengers;

  void setEmail(String? value) {
    email = value;
  }

  void setPhoneNumber(String? value) {
    phoneNumber = value;
  }

  void setDocument(DocumentModel? value) {
    document = value;
  }

  factory CreateFlightModel.fromJson(Map<String, dynamic> json) =>
      _$CreateFlightModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateFlightModelToJson(this);
}
