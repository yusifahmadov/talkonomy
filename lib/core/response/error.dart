import 'package:json_annotation/json_annotation.dart';

class ErrorI {
  @JsonKey(name: "error_description")
  final String errorDescription;

  ErrorI({required this.errorDescription});
}
