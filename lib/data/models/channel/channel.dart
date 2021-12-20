import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'channel.freezed.dart';

@freezed
class Channel with _$Channel {
  const factory Channel(
      {required String id,
      String? name,
      String? type,
      List<String>? roles}) = Data;
  const factory Channel.empty() = Empty;
  const factory Channel.error([String? message]) = ErrorDetails;
}
