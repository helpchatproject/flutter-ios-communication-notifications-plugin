// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class NotificationInfo {
  final String senderName;
  final Uint8List imageBytes;
  final String content;
  final String id;
  final String value;
  final Function(String payload)? onPressed;
  NotificationInfo({
    required this.senderName,
    required this.imageBytes,
    required this.content,
    required this.id,
    required this.value,
    this.onPressed,
  });

  NotificationInfo copyWith({
    String? senderName,
    Uint8List? imageBytes,
    String? content,
    String? value,
    String? id,
    Function(String payload)? onPressed,
  }) {
    return NotificationInfo(
      id: id ?? this.id,
      senderName: senderName ?? this.senderName,
      imageBytes: imageBytes ?? this.imageBytes,
      content: content ?? this.content,
      value: value ?? this.value,
      onPressed: onPressed ?? this.onPressed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderName': senderName,
      'imageBytes': imageBytes,
      'content': content,
      'value': value,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'NotificationInfo(senderName: $senderName, imageBytes: $imageBytes, content: $content, value: $value, onPressed: $onPressed)';
  }

  @override
  bool operator ==(covariant NotificationInfo other) {
    if (identical(this, other)) return true;

    return other.senderName == senderName &&
        other.imageBytes == imageBytes &&
        other.id == id &&
        other.content == content &&
        other.value == value &&
        other.onPressed == onPressed;
  }

  @override
  int get hashCode {
    return senderName.hashCode ^
        imageBytes.hashCode ^
        id.hashCode ^
        content.hashCode ^
        value.hashCode ^
        onPressed.hashCode;
  }
}
