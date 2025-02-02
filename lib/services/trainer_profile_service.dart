import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:werdanyfitnesspro/models/trainer_profile.dart';

class TrainerProfileService {
  static final TrainerProfileService _instance = TrainerProfileService._internal();
  factory TrainerProfileService() => _instance;
  TrainerProfileService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'trainer_profiles.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE trainer_profiles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            phone TEXT,
            address TEXT,
            clients TEXT
          )
        ''');
      },
    );
  }

  Future<void> addClient(TrainerProfile client) async {
    final db = await database;
    await db.insert(
      'trainer_profiles',
      client.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateClient(TrainerProfile client) async {
    final db = await database;
    await db.update(
      'trainer_profiles',
      client.toJson(),
      where: 'id = ?',
      whereArgs: [client.id],
    );
  }

  Future<void> deleteClient(int id) async {
    final db = await database;
    await db.delete(
      'trainer_profiles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TrainerProfile>> getClients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('trainer_profiles');
    return List.generate(maps.length, (i) {
      return TrainerProfile.fromJson(maps[i]);
    });
  }

  Future<TrainerProfile?> getLatestClient() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'trainer_profiles',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return TrainerProfile.fromJson(maps.first);
    } else {
      return null;
    }
  }
}
