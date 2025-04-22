// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lecture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Lecture _$LectureFromJson(Map<String, dynamic> json) {
  return _Lecture.fromJson(json);
}

/// @nodoc
mixin _$Lecture {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int? get lectureType => throw _privateConstructorUsedError;
  int get orderNo => throw _privateConstructorUsedError;
  bool get isOpened => throw _privateConstructorUsedError;
  bool get isPreview => throw _privateConstructorUsedError;
  int get totalPageCount => throw _privateConstructorUsedError;
  int get totalPagePoint => throw _privateConstructorUsedError;
  String? get testDescription => throw _privateConstructorUsedError;
  bool? get testScoreOpened => throw _privateConstructorUsedError;

  /// Serializes this Lecture to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LectureCopyWith<Lecture> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureCopyWith<$Res> {
  factory $LectureCopyWith(Lecture value, $Res Function(Lecture) then) =
      _$LectureCopyWithImpl<$Res, Lecture>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      int? lectureType,
      int orderNo,
      bool isOpened,
      bool isPreview,
      int totalPageCount,
      int totalPagePoint,
      String? testDescription,
      bool? testScoreOpened});
}

/// @nodoc
class _$LectureCopyWithImpl<$Res, $Val extends Lecture>
    implements $LectureCopyWith<$Res> {
  _$LectureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? lectureType = freezed,
    Object? orderNo = null,
    Object? isOpened = null,
    Object? isPreview = null,
    Object? totalPageCount = null,
    Object? totalPagePoint = null,
    Object? testDescription = freezed,
    Object? testScoreOpened = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      lectureType: freezed == lectureType
          ? _value.lectureType
          : lectureType // ignore: cast_nullable_to_non_nullable
              as int?,
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as int,
      isOpened: null == isOpened
          ? _value.isOpened
          : isOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreview: null == isPreview
          ? _value.isPreview
          : isPreview // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPageCount: null == totalPageCount
          ? _value.totalPageCount
          : totalPageCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPagePoint: null == totalPagePoint
          ? _value.totalPagePoint
          : totalPagePoint // ignore: cast_nullable_to_non_nullable
              as int,
      testDescription: freezed == testDescription
          ? _value.testDescription
          : testDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      testScoreOpened: freezed == testScoreOpened
          ? _value.testScoreOpened
          : testScoreOpened // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LectureImplCopyWith<$Res> implements $LectureCopyWith<$Res> {
  factory _$$LectureImplCopyWith(
          _$LectureImpl value, $Res Function(_$LectureImpl) then) =
      __$$LectureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      int? lectureType,
      int orderNo,
      bool isOpened,
      bool isPreview,
      int totalPageCount,
      int totalPagePoint,
      String? testDescription,
      bool? testScoreOpened});
}

/// @nodoc
class __$$LectureImplCopyWithImpl<$Res>
    extends _$LectureCopyWithImpl<$Res, _$LectureImpl>
    implements _$$LectureImplCopyWith<$Res> {
  __$$LectureImplCopyWithImpl(
      _$LectureImpl _value, $Res Function(_$LectureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? lectureType = freezed,
    Object? orderNo = null,
    Object? isOpened = null,
    Object? isPreview = null,
    Object? totalPageCount = null,
    Object? totalPagePoint = null,
    Object? testDescription = freezed,
    Object? testScoreOpened = freezed,
  }) {
    return _then(_$LectureImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      lectureType: freezed == lectureType
          ? _value.lectureType
          : lectureType // ignore: cast_nullable_to_non_nullable
              as int?,
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as int,
      isOpened: null == isOpened
          ? _value.isOpened
          : isOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreview: null == isPreview
          ? _value.isPreview
          : isPreview // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPageCount: null == totalPageCount
          ? _value.totalPageCount
          : totalPageCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPagePoint: null == totalPagePoint
          ? _value.totalPagePoint
          : totalPagePoint // ignore: cast_nullable_to_non_nullable
              as int,
      testDescription: freezed == testDescription
          ? _value.testDescription
          : testDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      testScoreOpened: freezed == testScoreOpened
          ? _value.testScoreOpened
          : testScoreOpened // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LectureImpl implements _Lecture {
  const _$LectureImpl(
      {required this.id,
      required this.title,
      required this.description,
      this.lectureType,
      this.orderNo = 0,
      this.isOpened = true,
      this.isPreview = false,
      this.totalPageCount = 0,
      this.totalPagePoint = 0,
      this.testDescription,
      this.testScoreOpened});

  factory _$LectureImpl.fromJson(Map<String, dynamic> json) =>
      _$$LectureImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int? lectureType;
  @override
  @JsonKey()
  final int orderNo;
  @override
  @JsonKey()
  final bool isOpened;
  @override
  @JsonKey()
  final bool isPreview;
  @override
  @JsonKey()
  final int totalPageCount;
  @override
  @JsonKey()
  final int totalPagePoint;
  @override
  final String? testDescription;
  @override
  final bool? testScoreOpened;

  @override
  String toString() {
    return 'Lecture(id: $id, title: $title, description: $description, lectureType: $lectureType, orderNo: $orderNo, isOpened: $isOpened, isPreview: $isPreview, totalPageCount: $totalPageCount, totalPagePoint: $totalPagePoint, testDescription: $testDescription, testScoreOpened: $testScoreOpened)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LectureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.lectureType, lectureType) ||
                other.lectureType == lectureType) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.isOpened, isOpened) ||
                other.isOpened == isOpened) &&
            (identical(other.isPreview, isPreview) ||
                other.isPreview == isPreview) &&
            (identical(other.totalPageCount, totalPageCount) ||
                other.totalPageCount == totalPageCount) &&
            (identical(other.totalPagePoint, totalPagePoint) ||
                other.totalPagePoint == totalPagePoint) &&
            (identical(other.testDescription, testDescription) ||
                other.testDescription == testDescription) &&
            (identical(other.testScoreOpened, testScoreOpened) ||
                other.testScoreOpened == testScoreOpened));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      lectureType,
      orderNo,
      isOpened,
      isPreview,
      totalPageCount,
      totalPagePoint,
      testDescription,
      testScoreOpened);

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LectureImplCopyWith<_$LectureImpl> get copyWith =>
      __$$LectureImplCopyWithImpl<_$LectureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LectureImplToJson(
      this,
    );
  }
}

abstract class _Lecture implements Lecture {
  const factory _Lecture(
      {required final int id,
      required final String title,
      required final String description,
      final int? lectureType,
      final int orderNo,
      final bool isOpened,
      final bool isPreview,
      final int totalPageCount,
      final int totalPagePoint,
      final String? testDescription,
      final bool? testScoreOpened}) = _$LectureImpl;

  factory _Lecture.fromJson(Map<String, dynamic> json) = _$LectureImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int? get lectureType;
  @override
  int get orderNo;
  @override
  bool get isOpened;
  @override
  bool get isPreview;
  @override
  int get totalPageCount;
  @override
  int get totalPagePoint;
  @override
  String? get testDescription;
  @override
  bool? get testScoreOpened;

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LectureImplCopyWith<_$LectureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
