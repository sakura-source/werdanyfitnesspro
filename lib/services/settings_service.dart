import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:werdanyfitnesspro/models/settings.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'settings.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE settings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            notifications_enabled BOOLEAN DEFAULT TRUE,
            dark_mode_enabled BOOLEAN DEFAULT FALSE,
            preferred_workout_type TEXT DEFAULT 'strength' CHECK (preferred_workout_type IN ('strength', 'cardio', 'flexibility', 'balance')),
            language TEXT DEFAULT 'English' CHECK (language IN ('English', 'Arabic', 'Other')),
            goal_deadline DATE DEFAULT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  Future<void> addSettings(Settings settings) async {
    final db = await database;
    await db.insert(
      'settings',
      settings.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateSettings(Settings settings) async {
    final db = await database;
    await db.update(
      'settings',
      settings.toJson(),
      where: 'id = ?',
      whereArgs: [settings.id],
    );
  }

  Future<void> deleteSettings(int id) async {
    final db = await database;
    await db.delete(
      'settings',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Settings?> getSettings(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'settings',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return Settings.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<Settings?> getSettingsByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'settings',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return Settings.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<Settings?> getLatestSettings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'settings',
      orderBy: 'created_at DESC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return Settings.fromJson(maps.first);
    } else {
      return null;
    }
  }
}
