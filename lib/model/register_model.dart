import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel {
  String? email;
  String? password;

  RegisterModel({this.email, this.password});

  // Factory constructor for JSON deserialization
  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
