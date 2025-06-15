import 'package:equatable/equatable.dart';

final class NameState extends Equatable {
  const NameState({
    this.isLoading,
  });

  final bool? isLoading;

  @override
  List<Object?> get props => [isLoading];

  NameState copyWith({
    bool? isLoading,
  }) {
    return NameState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
