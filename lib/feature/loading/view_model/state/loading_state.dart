import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class LoadingState extends Equatable {
  const LoadingState(
      {required this.isLoading,
      this.model,
      this.users,
      this.isfirstime = true,});

  final bool isLoading;
  final List<User>? users;
  final LoginResponseModel2? model;
  final bool isfirstime;
  @override
  List<Object?> get props => [isLoading, users, model, isfirstime];

  LoadingState copyWith({
    bool? isLoading,
    List<User>? users,
    LoginResponseModel2? model,
    bool? isfirstime,
  }) {
    return LoadingState(
      model: model ?? this.model,
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      isfirstime: isfirstime ?? this.isfirstime,
    );
  }
}
