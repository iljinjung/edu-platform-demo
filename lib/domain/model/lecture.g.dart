// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LectureImpl _$$LectureImplFromJson(Map<String, dynamic> json) =>
    _$LectureImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      lectureType: (json['lectureType'] as num?)?.toInt(),
      orderNo: (json['orderNo'] as num?)?.toInt() ?? 0,
      isOpened: json['isOpened'] as bool? ?? true,
      isPreview: json['isPreview'] as bool? ?? false,
      isFree: json['is_free'] as bool? ?? false,
      totalPageCount: (json['totalPageCount'] as num?)?.toInt() ?? 0,
      totalPagePoint: (json['totalPagePoint'] as num?)?.toInt() ?? 0,
      testDescription: json['testDescription'] as String?,
      testScoreOpened: json['testScoreOpened'] as bool?,
    );

Map<String, dynamic> _$$LectureImplToJson(_$LectureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'lectureType': instance.lectureType,
      'orderNo': instance.orderNo,
      'isOpened': instance.isOpened,
      'isPreview': instance.isPreview,
      'is_free': instance.isFree,
      'totalPageCount': instance.totalPageCount,
      'totalPagePoint': instance.totalPagePoint,
      'testDescription': instance.testDescription,
      'testScoreOpened': instance.testScoreOpened,
    };
