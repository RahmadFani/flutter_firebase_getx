import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const factory Profile(
      {required String id,
      String? nickname,
      String? avatar,
      List<String>? channels}) = Data;
  const factory Profile.empty() = Empty;
  const factory Profile.error([String? message]) = ErrorDetails;
}
