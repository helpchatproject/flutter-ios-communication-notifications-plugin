// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class NotificationCancel {
  final String identifier;

  NotificationCancel({
    required this.identifier,
  });

  NotificationCancel copyWith({
    required String identifier,
  }) {
    return NotificationCancel(
      identifier: identifier,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identifier': identifier,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'NotificationCancel(identifier: $identifier)';
  }

  @override
  bool operator ==(covariant NotificationCancel other) {
    if (identical(this, other)) return true;

    return other.identifier == identifier;
  }

  @override
  int get hashCode {
    return identifier.hashCode;
  }
}
