// lib/app/models/user_model.dart
import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String phone;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
  });

  // Empty user factory constructor
  factory User.empty() => User(
    id: '',
    username: '',
    email: '',
    password: '',
    phone: '',
  );

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  // Create from Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  // JSON conversion
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}