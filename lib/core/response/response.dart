import 'package:json_annotation/json_annotation.dart';

class ResponseI {
  @JsonKey(name: "msg")
  String message;

  ResponseI(this.message);
}
