//디코딩
import 'package:flutter_json_serializable_app/address.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String name;
  final String email;
  final Address adress;
  @JsonKey(name: 'createdtime')
  final int createdTime;
  User(
    this.name,
    this.email,
    this.createdTime,
    this.adress,
  );

  //formJson
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  //ToJosn
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
