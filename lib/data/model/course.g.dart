// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      shortDescription: json['shortDescription'] as String,
      description: json['description'] as String,
      imageFileUrl: json['imageFileUrl'] as String,
      logoFileUrl: json['logoFileUrl'] as String,
      taglist:
          (json['taglist'] as List<dynamic>).map((e) => e as String).toList(),
      isRecommended: json['isRecommended'] as bool? ?? false,
      isFree: json['isFree'] as bool? ?? false,
      price: json['price'] as String?,
      discountedPrice: json['discountedPrice'] as String?,
      discountRate: json['discountRate'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'imageFileUrl': instance.imageFileUrl,
      'logoFileUrl': instance.logoFileUrl,
      'taglist': instance.taglist,
      'isRecommended': instance.isRecommended,
      'isFree': instance.isFree,
      'price': instance.price,
      'discountedPrice': instance.discountedPrice,
      'discountRate': instance.discountRate,
      'isFavorite': instance.isFavorite,
    };
