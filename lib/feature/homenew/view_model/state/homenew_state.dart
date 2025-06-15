import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class HomenewState extends Equatable {
  const HomenewState({
    required this.isLoading,
    required this.opacity,
    required this.favCount,
    this.content,
    this.users,
    this.imageHeight,
    this.data,
    this.favorites = const {},
    this.isLoadingFavRpc = false,
  });

  final bool isLoading;
  final List<User>? users;
  final List<Content>? content;
  final double? opacity;
  final double? imageHeight;
  final List<Map<String, dynamic>>? data;
  final Map<String, bool> favorites;
  final bool isLoadingFavRpc;
  final int favCount;

  @override
  List<Object?> get props => [
        isLoading,
        users,
        content,
        opacity,
        imageHeight,
        data,
        favorites,
        isLoadingFavRpc,
        favCount,
      ];

  HomenewState copyWith({
    bool? isLoading,
    List<User>? users,
    List<Content>? content,
    double? opacity,
    double? imageHeight,
    List<Map<String, dynamic>>? data,
    Map<String, bool>? favorites,
    bool? isLoadingFavRpc,
    int? favCount
  }) {
    return HomenewState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      content: content ?? this.content,
      opacity: opacity ?? this.opacity,
      imageHeight: imageHeight ?? this.imageHeight,
      data: data ?? this.data,
      favorites: favorites ?? this.favorites,
      isLoadingFavRpc: isLoadingFavRpc ?? this.isLoadingFavRpc,
      favCount: favCount ?? this.favCount
    );
  }
}
