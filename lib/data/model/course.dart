import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const factory Course({
    required int id,
    required String title,
    @JsonKey(name: 'short_description') required String shortDescription,
    required String description,
    @JsonKey(name: 'image_file_url') required String imageFileUrl,
    @JsonKey(name: 'logo_file_url') required String logoFileUrl,
    required List<String> taglist,
    @JsonKey(name: 'is_recommended') @Default(false) bool isRecommended,
    @JsonKey(name: 'is_free') @Default(false) bool isFree,
    String? price,
    @JsonKey(name: 'discounted_price') String? discountedPrice,
    @JsonKey(name: 'discount_rate') String? discountRate,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
