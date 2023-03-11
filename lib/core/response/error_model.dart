import 'error.dart';
import 'package:json_annotation/json_annotation.dart';
part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel extends ErrorI {
  ErrorModel({required super.errorDescription});
  factory ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
