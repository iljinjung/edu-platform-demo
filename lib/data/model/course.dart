import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const factory Course({
    required int id,
    required String title,
    required String shortDescription,
    required String description,
    required String imageFileUrl,
    required String logoFileUrl,
    required List<String> taglist,
    @Default(false) bool isRecommended,
    @Default(false) bool isFree,
    String? price,
    String? discountedPrice,
    String? discountRate,
    @Default(false) bool isFavorite,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
