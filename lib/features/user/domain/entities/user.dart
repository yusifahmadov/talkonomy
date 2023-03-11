import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class User extends Equatable {
  @override
  List<Object?> get props => [];

  final String? id;
  final String? name;
  final String? surname;
  final DateTime? age;
  @JsonKey(name: "profile_image")
  final String? profileImage;
  final bool? verified;

  const User(
      {required this.id, required this.name, required this.surname, required this.age, required this.profileImage, required this.verified});
}
