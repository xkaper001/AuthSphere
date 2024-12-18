// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Response {
  final String eventType;
  final String email;
  final String details;
  final String timestamp;
  final String ipAddress;
  Response({
    required this.eventType,
    required this.email,
    required this.details,
    required this.timestamp,
    required this.ipAddress,
  });


  Response copyWith({
    String? eventType,
    String? email,
    String? details,
    String? timestamp,
    String? ipAddress,
  }) {
    return Response(
      eventType: eventType ?? this.eventType,
      email: email ?? this.email,
      details: details ?? this.details,
      timestamp: timestamp ?? this.timestamp,
      ipAddress: ipAddress ?? this.ipAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventType': eventType,
      'email': email,
      'details': details,
      'timestamp': timestamp,
      'ipAddress': ipAddress,
    };
  }

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      eventType: map['eventType'] as String,
      email: map['email'] as String,
      details: map['details'] as String,
      timestamp: map['timestamp'] as String,
      ipAddress: map['ipAddress'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Response.fromJson(String source) => Response.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Response(eventType: $eventType, email: $email, details: $details, timestamp: $timestamp, ipAddress: $ipAddress)';
  }

  @override
  bool operator ==(covariant Response other) {
    if (identical(this, other)) return true;
  
    return 
      other.eventType == eventType &&
      other.email == email &&
      other.details == details &&
      other.timestamp == timestamp &&
      other.ipAddress == ipAddress;
  }

  @override
  int get hashCode {
    return eventType.hashCode ^
      email.hashCode ^
      details.hashCode ^
      timestamp.hashCode ^
      ipAddress.hashCode;
  }
}
