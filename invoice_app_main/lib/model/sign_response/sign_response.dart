import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'data.dart';

@immutable
class SignResponse {
  final bool? success;
  final String? message;
  final Data? data;

  const SignResponse({this.success, this.message, this.data});

  @override
  String toString() {
    return 'SignResponse(success: $success, message: $message, data: $data)';
  }

  factory SignResponse.fromMap(Map<String, dynamic> data) => SignResponse(
        success: data['success'] as bool?,
        message: data['message'] as String?,
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'success': success,
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SignResponse].
  factory SignResponse.fromJson(String data) {
    return SignResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SignResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  SignResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return SignResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SignResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
