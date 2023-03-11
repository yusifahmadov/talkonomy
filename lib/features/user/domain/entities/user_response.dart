import 'package:json_annotation/json_annotation.dart';
import '../../data/models/user_model.dart';

class UserResponse {
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  final UserModel user;

  UserResponse({required this.accessToken, required this.refreshToken, required this.user});
}
