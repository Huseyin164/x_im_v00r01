import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    required this.isLoading,
    this.model,
    this.users,
    this.user,
  });

  final bool isLoading;
  final List<User>? users;
  final LoginResponseModel2? model;
  final User? user;

  @override
  List<Object?> get props => [isLoading, users, model, user];

  SettingsState copyWith({
    bool? isLoading,
    List<User>? users,
    LoginResponseModel2? model,
    User? user,
  }) {
    return SettingsState(
      model: model ?? this.model,
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      user: user ?? this.user,
    );
  }
}
