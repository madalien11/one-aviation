import 'package:json_annotation/json_annotation.dart';
import 'package:one_aviation/src/models/document/document_model.dart';
import 'package:one_aviation/src/models/passenger/passenger_model.dart';

part 'join_flight_model.g.dart';

@JsonSerializable()
class JoinFlightModel {
  JoinFlightModel({
    required this.document,
    required this.email,
    required this.orderId,
    required this.passengers,
    required this.phoneNumber,
  });

  final DocumentModel document;
  final String email;
  @JsonKey(name: 'order_id')
  final int orderId;
  final List<PassengerModel> passengers;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  factory JoinFlightModel.fromJson(Map<String, dynamic> json) =>
      _$JoinFlightModelFromJson(json);
  Map<String, dynamic> toJson() => _$JoinFlightModelToJson(this);
}
