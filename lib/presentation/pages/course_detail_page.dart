import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:edu_platform_demo/data/model/course.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              course.imageFileUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.shortDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  if (course.markdownHtml.isNotEmpty)
                    Html(
                      data: course.markdownHtml,
                      style: {
                        "body": Style(
                          fontSize: FontSize(16),
                        ),
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
