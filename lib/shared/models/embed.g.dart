// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BonfireEmbed _$BonfireEmbedFromJson(Map<String, dynamic> json) => BonfireEmbed(
      width: json['width'] as int?,
      height: json['height'] as int?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      color: const ColorConverter().fromJson(json['color'] as int?),
    );

Map<String, dynamic> _$BonfireEmbedToJson(BonfireEmbed instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'thumbnailUrl': instance.thumbnailUrl,
      'color': const ColorConverter().toJson(instance.color),
    };
