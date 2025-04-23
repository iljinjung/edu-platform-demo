import 'package:flutter/foundation.dart';

class Course {
  final int id;
  final String title;
  final String shortDescription;
  final String description;
  final String imageFileUrl;
  final String logoFileUrl;
  final List<String> taglist;
  final bool isRecommended;
  final bool isFree;
  final String? price;
  final String? discountedPrice;
  final String? discountRate;
  final bool isFavorite;
  final String markdownHtml;

  Course({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.imageFileUrl,
    required this.logoFileUrl,
    required this.taglist,
    required this.isRecommended,
    required this.isFree,
    this.price,
    this.discountedPrice,
    this.discountRate,
    required this.isFavorite,
    this.markdownHtml = '',
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: _intFromJson(json['id']),
      title: _stringFromJson(json['title']),
      shortDescription: _stringFromJson(json['short_description']),
      description: _stringFromJson(json['description']),
      imageFileUrl: _stringFromJson(json['image_file_url']),
      logoFileUrl: _stringFromJson(json['logo_file_url']),
      taglist: _stringListFromJson(json['taglist']),
      isRecommended: json['is_recommended'] ?? false,
      isFree: json['is_free'] ?? false,
      price: _nullableString(json['price']),
      discountedPrice: _nullableString(json['discounted_price']),
      discountRate: _nullableString(json['discount_rate']),
      isFavorite: json['is_favorite'] ?? false,
      markdownHtml: _extractMarkdownHtml(json['preference']),
    );
  }
}

String _stringFromJson(dynamic value) => value?.toString() ?? '';
int _intFromJson(dynamic value) => value == null ? 0 : (value as num).toInt();
String? _nullableString(dynamic value) => value?.toString();
List<String> _stringListFromJson(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.map((e) => e?.toString() ?? '').toList();
  return [];
}

String _extractMarkdownHtml(dynamic preference) {
  try {
    final sections = preference?['landing']?['configs_v2']?['sections'];
    if (sections is List) {
      for (final section in sections) {
        if (section['type'] == 'markdown') {
          final content = section['payload']?['content'];
          if (content is String && content.trim().isNotEmpty) {
            return content;
          }
        }
      }
    }
  } catch (_) {}
  return '';
}
