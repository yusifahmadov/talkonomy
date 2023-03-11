// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      age: json['age'] == null ? null : DateTime.parse(json['age'] as String),
      profileImage: json['profile_image'] as String?,
      verified: json['verified'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'age': instance.age?.toIso8601String(),
      'profile_image': instance.profileImage,
      'verified': instance.verified,
    };
