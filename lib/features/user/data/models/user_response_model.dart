import '../../domain/entities/user_response.dart';
import 'user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_response_model.g.dart';

@JsonSerializable()
class UserResponseModel extends UserResponse {
  UserResponseModel({required super.accessToken, required super.refreshToken, required super.user});
  factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}
