// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      shortDescription: json['short_description'] as String,
      description: json['description'] as String,
      imageFileUrl: json['image_file_url'] as String,
      logoFileUrl: json['logo_file_url'] as String,
      taglist:
          (json['taglist'] as List<dynamic>).map((e) => e as String).toList(),
      isRecommended: json['is_recommended'] as bool? ?? false,
      isFree: json['is_free'] as bool? ?? false,
      price: json['price'] as String?,
      discountedPrice: json['discounted_price'] as String?,
      discountRate: json['discount_rate'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'short_description': instance.shortDescription,
      'description': instance.description,
      'image_file_url': instance.imageFileUrl,
      'logo_file_url': instance.logoFileUrl,
      'taglist': instance.taglist,
      'is_recommended': instance.isRecommended,
      'is_free': instance.isFree,
      'price': instance.price,
      'discounted_price': instance.discountedPrice,
      'discount_rate': instance.discountRate,
      'is_favorite': instance.isFavorite,
    };
