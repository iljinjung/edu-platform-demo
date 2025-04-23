// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: _intFromJson(json['id']),
      title: _stringFromJson(json['title']),
      shortDescription: _stringFromJson(json['short_description']),
      description: _stringFromJson(json['description']),
      imageFileUrl: _stringFromJson(json['image_file_url']),
      logoFileUrl: _stringFromJson(json['logo_file_url']),
      taglist: _stringListFromJson(json['taglist']),
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
