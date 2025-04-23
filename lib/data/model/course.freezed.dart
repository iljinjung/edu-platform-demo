// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
mixin _$Course {
  @JsonKey(fromJson: _intFromJson)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringFromJson)
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'short_description', fromJson: _stringFromJson)
  String get shortDescription => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringFromJson)
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_file_url', fromJson: _stringFromJson)
  String get imageFileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_file_url', fromJson: _stringFromJson)
  String get logoFileUrl => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringListFromJson)
  List<String> get taglist => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_recommended')
  bool get isRecommended => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_free')
  bool get isFree => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'discounted_price')
  String? get discountedPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_rate')
  String? get discountRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_favorite')
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Serializes this Course to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res, Course>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _intFromJson) int id,
      @JsonKey(fromJson: _stringFromJson) String title,
      @JsonKey(name: 'short_description', fromJson: _stringFromJson)
      String shortDescription,
      @JsonKey(fromJson: _stringFromJson) String description,
      @JsonKey(name: 'image_file_url', fromJson: _stringFromJson)
      String imageFileUrl,
      @JsonKey(name: 'logo_file_url', fromJson: _stringFromJson)
      String logoFileUrl,
      @JsonKey(fromJson: _stringListFromJson) List<String> taglist,
      @JsonKey(name: 'is_recommended') bool isRecommended,
      @JsonKey(name: 'is_free') bool isFree,
      String? price,
      @JsonKey(name: 'discounted_price') String? discountedPrice,
      @JsonKey(name: 'discount_rate') String? discountRate,
      @JsonKey(name: 'is_favorite') bool isFavorite});
}

/// @nodoc
class _$CourseCopyWithImpl<$Res, $Val extends Course>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? description = null,
    Object? imageFileUrl = null,
    Object? logoFileUrl = null,
    Object? taglist = null,
    Object? isRecommended = null,
    Object? isFree = null,
    Object? price = freezed,
    Object? discountedPrice = freezed,
    Object? discountRate = freezed,
    Object? isFavorite = null,
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
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageFileUrl: null == imageFileUrl
          ? _value.imageFileUrl
          : imageFileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      logoFileUrl: null == logoFileUrl
          ? _value.logoFileUrl
          : logoFileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      taglist: null == taglist
          ? _value.taglist
          : taglist // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isRecommended: null == isRecommended
          ? _value.isRecommended
          : isRecommended // ignore: cast_nullable_to_non_nullable
              as bool,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      discountedPrice: freezed == discountedPrice
          ? _value.discountedPrice
          : discountedPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      discountRate: freezed == discountRate
          ? _value.discountRate
          : discountRate // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseImplCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$CourseImplCopyWith(
          _$CourseImpl value, $Res Function(_$CourseImpl) then) =
      __$$CourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _intFromJson) int id,
      @JsonKey(fromJson: _stringFromJson) String title,
      @JsonKey(name: 'short_description', fromJson: _stringFromJson)
      String shortDescription,
      @JsonKey(fromJson: _stringFromJson) String description,
      @JsonKey(name: 'image_file_url', fromJson: _stringFromJson)
      String imageFileUrl,
      @JsonKey(name: 'logo_file_url', fromJson: _stringFromJson)
      String logoFileUrl,
      @JsonKey(fromJson: _stringListFromJson) List<String> taglist,
      @JsonKey(name: 'is_recommended') bool isRecommended,
      @JsonKey(name: 'is_free') bool isFree,
      String? price,
      @JsonKey(name: 'discounted_price') String? discountedPrice,
      @JsonKey(name: 'discount_rate') String? discountRate,
      @JsonKey(name: 'is_favorite') bool isFavorite});
}

/// @nodoc
class __$$CourseImplCopyWithImpl<$Res>
    extends _$CourseCopyWithImpl<$Res, _$CourseImpl>
    implements _$$CourseImplCopyWith<$Res> {
  __$$CourseImplCopyWithImpl(
      _$CourseImpl _value, $Res Function(_$CourseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? description = null,
    Object? imageFileUrl = null,
    Object? logoFileUrl = null,
    Object? taglist = null,
    Object? isRecommended = null,
    Object? isFree = null,
    Object? price = freezed,
    Object? discountedPrice = freezed,
    Object? discountRate = freezed,
    Object? isFavorite = null,
  }) {
    return _then(_$CourseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageFileUrl: null == imageFileUrl
          ? _value.imageFileUrl
          : imageFileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      logoFileUrl: null == logoFileUrl
          ? _value.logoFileUrl
          : logoFileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      taglist: null == taglist
          ? _value._taglist
          : taglist // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isRecommended: null == isRecommended
          ? _value.isRecommended
          : isRecommended // ignore: cast_nullable_to_non_nullable
              as bool,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      discountedPrice: freezed == discountedPrice
          ? _value.discountedPrice
          : discountedPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      discountRate: freezed == discountRate
          ? _value.discountRate
          : discountRate // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseImpl implements _Course {
  const _$CourseImpl(
      {@JsonKey(fromJson: _intFromJson) required this.id,
      @JsonKey(fromJson: _stringFromJson) required this.title,
      @JsonKey(name: 'short_description', fromJson: _stringFromJson)
      required this.shortDescription,
      @JsonKey(fromJson: _stringFromJson) required this.description,
      @JsonKey(name: 'image_file_url', fromJson: _stringFromJson)
      required this.imageFileUrl,
      @JsonKey(name: 'logo_file_url', fromJson: _stringFromJson)
      required this.logoFileUrl,
      @JsonKey(fromJson: _stringListFromJson)
      required final List<String> taglist,
      @JsonKey(name: 'is_recommended') this.isRecommended = false,
      @JsonKey(name: 'is_free') this.isFree = false,
      this.price,
      @JsonKey(name: 'discounted_price') this.discountedPrice,
      @JsonKey(name: 'discount_rate') this.discountRate,
      @JsonKey(name: 'is_favorite') this.isFavorite = false})
      : _taglist = taglist;

  factory _$CourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseImplFromJson(json);

  @override
  @JsonKey(fromJson: _intFromJson)
  final int id;
  @override
  @JsonKey(fromJson: _stringFromJson)
  final String title;
  @override
  @JsonKey(name: 'short_description', fromJson: _stringFromJson)
  final String shortDescription;
  @override
  @JsonKey(fromJson: _stringFromJson)
  final String description;
  @override
  @JsonKey(name: 'image_file_url', fromJson: _stringFromJson)
  final String imageFileUrl;
  @override
  @JsonKey(name: 'logo_file_url', fromJson: _stringFromJson)
  final String logoFileUrl;
  final List<String> _taglist;
  @override
  @JsonKey(fromJson: _stringListFromJson)
  List<String> get taglist {
    if (_taglist is EqualUnmodifiableListView) return _taglist;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taglist);
  }

  @override
  @JsonKey(name: 'is_recommended')
  final bool isRecommended;
  @override
  @JsonKey(name: 'is_free')
  final bool isFree;
  @override
  final String? price;
  @override
  @JsonKey(name: 'discounted_price')
  final String? discountedPrice;
  @override
  @JsonKey(name: 'discount_rate')
  final String? discountRate;
  @override
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;

  @override
  String toString() {
    return 'Course(id: $id, title: $title, shortDescription: $shortDescription, description: $description, imageFileUrl: $imageFileUrl, logoFileUrl: $logoFileUrl, taglist: $taglist, isRecommended: $isRecommended, isFree: $isFree, price: $price, discountedPrice: $discountedPrice, discountRate: $discountRate, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageFileUrl, imageFileUrl) ||
                other.imageFileUrl == imageFileUrl) &&
            (identical(other.logoFileUrl, logoFileUrl) ||
                other.logoFileUrl == logoFileUrl) &&
            const DeepCollectionEquality().equals(other._taglist, _taglist) &&
            (identical(other.isRecommended, isRecommended) ||
                other.isRecommended == isRecommended) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.discountedPrice, discountedPrice) ||
                other.discountedPrice == discountedPrice) &&
            (identical(other.discountRate, discountRate) ||
                other.discountRate == discountRate) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      shortDescription,
      description,
      imageFileUrl,
      logoFileUrl,
      const DeepCollectionEquality().hash(_taglist),
      isRecommended,
      isFree,
      price,
      discountedPrice,
      discountRate,
      isFavorite);

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      __$$CourseImplCopyWithImpl<_$CourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseImplToJson(
      this,
    );
  }
}

abstract class _Course implements Course {
  const factory _Course(
      {@JsonKey(fromJson: _intFromJson) required final int id,
      @JsonKey(fromJson: _stringFromJson) required final String title,
      @JsonKey(name: 'short_description', fromJson: _stringFromJson)
      required final String shortDescription,
      @JsonKey(fromJson: _stringFromJson) required final String description,
      @JsonKey(name: 'image_file_url', fromJson: _stringFromJson)
      required final String imageFileUrl,
      @JsonKey(name: 'logo_file_url', fromJson: _stringFromJson)
      required final String logoFileUrl,
      @JsonKey(fromJson: _stringListFromJson)
      required final List<String> taglist,
      @JsonKey(name: 'is_recommended') final bool isRecommended,
      @JsonKey(name: 'is_free') final bool isFree,
      final String? price,
      @JsonKey(name: 'discounted_price') final String? discountedPrice,
      @JsonKey(name: 'discount_rate') final String? discountRate,
      @JsonKey(name: 'is_favorite') final bool isFavorite}) = _$CourseImpl;

  factory _Course.fromJson(Map<String, dynamic> json) = _$CourseImpl.fromJson;

  @override
  @JsonKey(fromJson: _intFromJson)
  int get id;
  @override
  @JsonKey(fromJson: _stringFromJson)
  String get title;
  @override
  @JsonKey(name: 'short_description', fromJson: _stringFromJson)
  String get shortDescription;
  @override
  @JsonKey(fromJson: _stringFromJson)
  String get description;
  @override
  @JsonKey(name: 'image_file_url', fromJson: _stringFromJson)
  String get imageFileUrl;
  @override
  @JsonKey(name: 'logo_file_url', fromJson: _stringFromJson)
  String get logoFileUrl;
  @override
  @JsonKey(fromJson: _stringListFromJson)
  List<String> get taglist;
  @override
  @JsonKey(name: 'is_recommended')
  bool get isRecommended;
  @override
  @JsonKey(name: 'is_free')
  bool get isFree;
  @override
  String? get price;
  @override
  @JsonKey(name: 'discounted_price')
  String? get discountedPrice;
  @override
  @JsonKey(name: 'discount_rate')
  String? get discountRate;
  @override
  @JsonKey(name: 'is_favorite')
  bool get isFavorite;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
