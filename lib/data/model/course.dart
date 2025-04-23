import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const factory Course({
    @JsonKey(fromJson: _intFromJson) required int id,
    @JsonKey(fromJson: _stringFromJson) required String title,
    @JsonKey(name: 'short_description', fromJson: _stringFromJson)
    required String shortDescription,
    @JsonKey(fromJson: _stringFromJson) required String description,
    @JsonKey(name: 'image_file_url', fromJson: _stringFromJson)
    required String imageFileUrl,
    @JsonKey(name: 'logo_file_url', fromJson: _stringFromJson)
    required String logoFileUrl,
    @JsonKey(fromJson: _stringListFromJson) required List<String> taglist,
    @JsonKey(name: 'is_recommended') @Default(false) bool isRecommended,
    @JsonKey(name: 'is_free') @Default(false) bool isFree,
    String? price,
    @JsonKey(name: 'discounted_price') String? discountedPrice,
    @JsonKey(name: 'discount_rate') String? discountRate,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}

String _stringFromJson(dynamic value) => value?.toString() ?? '';
int _intFromJson(dynamic value) => value == null ? 0 : (value as num).toInt();
List<String> _stringListFromJson(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.map((e) => e?.toString() ?? '').toList();
  return [];
}
