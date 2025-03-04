import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Başlangıç durumu
class AuthInitial extends BaseAuthState {}

// Kullanıcı oturum açtığında
class AuthAuthenticated extends BaseAuthState {

  AuthAuthenticated(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

// Kullanıcı çıkış yaptığında
class AuthUnauthenticated extends BaseAuthState {}

// Hata durumu
class AuthError extends BaseAuthState {

  AuthError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
