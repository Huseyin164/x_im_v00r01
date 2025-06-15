// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'storymodel.g.dart';

@JsonSerializable()
class StoryModel extends INetworkModel<StoryModel> with EquatableMixin {
  StoryModel({
    this.id,
    this.name,
    this.photoUrl,
    this.birthDate,
    this.createdAt,
    this.birthPlace,
    this.nationality,
    this.language,
    this.translations
  });

  /// Get story from json
  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  final String? id;
  final String? name;
  final String? photoUrl;
  final String? birthDate;
  final String? createdAt;
  final String? birthPlace;
  final String? nationality;
  final String? language;
  final Map<String, dynamic>? translations;

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        birthDate,
        createdAt,
        birthPlace,
        nationality,
        language,
        translations
      ];

  /// Story model to map object
  @override
  Map<String, dynamic> toJson() => _$StoryModelToJson(this);

  @override
  StoryModel fromJson(Map<String, dynamic> json) {
    return _$StoryModelFromJson(json);
  }

  StoryModel copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? birthDate,
    String? createdAt,
    String? birthPlace,
    String? nationality,
    String? language,
    Map<String, dynamic>? translations,
  }) {
    return StoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      birthDate: birthDate ?? this.birthDate,
      createdAt: createdAt ?? this.createdAt,
      birthPlace: birthPlace ?? this.birthPlace,
      nationality: nationality ?? this.nationality,
      language: language ?? this.language,
      translations: translations ?? this.translations,
    );
  }
}
