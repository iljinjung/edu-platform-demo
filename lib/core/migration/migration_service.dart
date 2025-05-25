import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_platform_demo/core/database/db_helper.dart'; // Adjust import path if necessary
import 'dart:developer' as dev;

class MigrationService {
  static const String _migrationDoneKey = 'enrollment_migration_to_sqflite_done';
  // This is the key used in EnrollmentRepositoryImpl for SharedPreferences.
  // We need to know this key to read the old data.
  // THIS KEY MUST MATCH THE ONE USED IN THE OLD EnrollmentRepositoryImpl.
  static const String _oldSharedPreferencesEnrollmentKey = 'enrolled_course_ids';


  final SharedPreferences _prefs;
  final DatabaseHelper _dbHelper;

  MigrationService({
    required SharedPreferences prefs,
    required DatabaseHelper dbHelper,
  })  : _prefs = prefs,
        _dbHelper = dbHelper;

  Future<void> migrateIfNeeded() async {
    final bool migrationDone = _prefs.getBool(_migrationDoneKey) ?? false;

    if (migrationDone) {
      dev.log('Enrollment migration to SQLite already completed.');
      return;
    }

    dev.log('Starting enrollment migration from SharedPreferences to SQLite...');

    try {
      // 1. Read from SharedPreferences
      // The old data was stored as a List<String> of course IDs.
      final List<String>? enrolledCourseIds = _prefs.getStringList(_oldSharedPreferencesEnrollmentKey);

      if (enrolledCourseIds == null || enrolledCourseIds.isEmpty) {
        dev.log('No enrollment data found in SharedPreferences to migrate.');
      } else {
        // 2. Write to SQLite database
        // Optional: Clear existing SQLite data if this is a fresh migration
        // await _dbHelper.clearEnrollments(); // Uncomment if a clean slate is needed before migration

        for (String courseId in enrolledCourseIds) {
          await _dbHelper.enrollCourse(courseId);
          dev.log('Migrated course: $courseId to SQLite.');
        }
        dev.log('Successfully migrated ${enrolledCourseIds.length} courses.');
      }

      // 3. Set migration done flag
      await _prefs.setBool(_migrationDoneKey, true);
      dev.log('Enrollment migration to SQLite marked as complete.');

      // 4. (Optional) Clear old SharedPreferences data
      // Be cautious with this step. Ensure migration is robust before uncommenting.
      // await _prefs.remove(_oldSharedPreferencesEnrollmentKey);
      // dev.log('Old enrollment data removed from SharedPreferences.');

    } catch (e, stackTrace) {
      dev.log('Error during enrollment migration: $e', stackTrace: stackTrace);
      // Handle error: maybe retry later, or log for analytics
      // For now, we don't set the migrationDone flag if an error occurs,
      // so it might retry on next app launch.
    }
  }
}
