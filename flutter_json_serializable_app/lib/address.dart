import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';
@JsonSerializable()
class Address {
  final String street;
  final String city;

  Address(this.street, this.city);

  //formJson
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  //ToJosn
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}