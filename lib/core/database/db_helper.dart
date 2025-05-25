import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io'; // For Directory

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  static const String _dbName = 'app_database.db';
  static const String _enrollmentsTable = 'enrollments';
  static const String _colCourseId = 'course_id';
  static const String _colIsEnrolled = 'is_enrolled'; // 1 for true, 0 for false

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_enrollmentsTable (
        $_colCourseId TEXT PRIMARY KEY,
        $_colIsEnrolled INTEGER NOT NULL
      )
    ''');
  }

  // --- CRUD Operations for Enrollments ---

  /// Enroll a course (or update if exists)
  Future<void> enrollCourse(String courseId) async {
    final db = await database;
    await db.insert(
      _enrollmentsTable,
      {_colCourseId: courseId, _colIsEnrolled: 1},
      conflictAlgorithm: ConflictAlgorithm.replace, // If already exists, update it
    );
  }

  /// Unenroll a course
  Future<void> unenrollCourse(String courseId) async {
    final db = await database;
    await db.delete(
      _enrollmentsTable,
      where: '$_colCourseId = ?',
      whereArgs: [courseId],
    );
  }

  /// Check if a course is enrolled
  Future<bool> isCourseEnrolled(String courseId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _enrollmentsTable,
      columns: [_colCourseId],
      where: '$_colCourseId = ? AND $_colIsEnrolled = ?',
      whereArgs: [courseId, 1],
    );
    return maps.isNotEmpty;
  }

  /// Get all enrolled course IDs
  Future<List<String>> getAllEnrolledCourseIds() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _enrollmentsTable,
      columns: [_colCourseId],
      where: '$_colIsEnrolled = ?',
      whereArgs: [1],
    );
    return maps.map((map) => map[_colCourseId] as String).toList();
  }
  
  /// Clear all enrollment data (for migration or testing)
  Future<void> clearEnrollments() async {
    final db = await database;
    await db.delete(_enrollmentsTable);
  }
}
