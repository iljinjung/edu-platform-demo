import 'package:freezed_annotation/freezed_annotation.dart';

part 'lecture.freezed.dart';
part 'lecture.g.dart';

@freezed
class Lecture with _$Lecture {
  const factory Lecture({
    required int id,
    required String title,
    required String description,
    int? lectureType,
    @Default(0) int orderNo,
    @Default(true) bool isOpened,
    @Default(false) bool isPreview,
    @Default(0) int totalPageCount,
    @Default(0) int totalPagePoint,
    String? testDescription,
    bool? testScoreOpened,
  }) = _Lecture;

  factory Lecture.fromJson(Map<String, dynamic> json) =>
      _$LectureFromJson(json);
}
