// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storymodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => StoryModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      photoUrl: json['photo_url'] as String?,
      birthDate: json['birth_date'] as String?,
      createdAt: json['created_at'] as String?,
      birthPlace: json['birth_palace'] as String?,
      nationality: json['nationality'] as String?,
      language: json['language'] as String?,
      translations: json['translations'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$StoryModelToJson(StoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'birthDate': instance.birthDate,
      'createdAt': instance.createdAt,
      'birthPlace': instance.birthPlace,
      'nationality': instance.nationality,
      'language': instance.language,
      'translations': instance.translations,
    };
