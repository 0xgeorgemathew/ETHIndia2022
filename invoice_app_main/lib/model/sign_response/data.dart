import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class Data {
  final String? userAddress;
  final String? cId;
  final String? ipfsLink;
  final String? signedMessage;

  const Data({this.userAddress, this.cId, this.ipfsLink, this.signedMessage});

  @override
  String toString() {
    return 'Data(userAddress: $userAddress, cId: $cId, ipfsLink: $ipfsLink, signedMessage: $signedMessage)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        userAddress: data['userAddress'] as String?,
        cId: data['cId'] as String?,
        ipfsLink: data['ipfsLink'] as String?,
        signedMessage: data['signedMessage'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'userAddress': userAddress,
        'cId': cId,
        'ipfsLink': ipfsLink,
        'signedMessage': signedMessage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    String? userAddress,
    String? cId,
    String? ipfsLink,
    String? signedMessage,
  }) {
    return Data(
      userAddress: userAddress ?? this.userAddress,
      cId: cId ?? this.cId,
      ipfsLink: ipfsLink ?? this.ipfsLink,
      signedMessage: signedMessage ?? this.signedMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      userAddress.hashCode ^
      cId.hashCode ^
      ipfsLink.hashCode ^
      signedMessage.hashCode;
}
