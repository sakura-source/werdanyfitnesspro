import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // الجداول الأساسية
        await db.execute('''
          CREATE TABLE body_stats (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            weight REAL,
            muscleMass REAL,
            fatPercentage REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE hormones (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            dosage REAL,
            schedule TEXT,
            purpose TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE diet_plans (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            calories INTEGER,
            protein INTEGER,
            carbs INTEGER,
            fats INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE progress_photos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            photoPath TEXT,
            date TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE trainer_profiles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            clients TEXT
          )
        ''');
        // الجداول المضافة
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            username TEXT UNIQUE NOT NULL,
            email TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL,
            phone_number TEXT UNIQUE,
            age INTEGER CHECK (age > 0),
            gender TEXT CHECK (gender IN ('male', 'female', 'other')) NOT NULL,
            height REAL CHECK (height > 0),
            weight REAL CHECK (weight > 0),
            goal TEXT CHECK (goal IN ('lose weight', 'maintain weight', 'gain weight')) NOT NULL,
            subscription_status TEXT DEFAULT 'free' CHECK (subscription_status IN ('free', 'premium')),
            avatar_url TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
          )
        ''');
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
        await db.execute('''
          CREATE TABLE hormone_tracking (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            hormone_name TEXT NOT NULL,
            level REAL NOT NULL,
            unit TEXT NOT NULL,
            normal_range TEXT,
            notes TEXT,
            test_date DATE NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE progress_tracking (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            weight REAL CHECK (weight > 0),
            body_fat_percentage REAL CHECK (body_fat_percentage >= 0),
            muscle_mass REAL CHECK (muscle_mass >= 0),
            water_intake REAL CHECK (water_intake >= 0),
            steps INTEGER CHECK (steps >= 0),
            BMI REAL GENERATED ALWAYS AS (weight / ((height / 100) * (height / 100))) STORED,
            date DATE NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE meals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            calories REAL CHECK (calories >= 0),
            protein REAL CHECK (protein >= 0),
            carbs REAL CHECK (carbs >= 0),
            fats REAL CHECK (fats >= 0),
            meal_type TEXT CHECK (meal_type IN ('breakfast', 'lunch', 'dinner', 'snack')) NOT NULL,
            date DATE NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE meal_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            meal_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            calories REAL CHECK (calories >= 0),
            protein REAL CHECK (protein >= 0),
            carbs REAL CHECK (carbs >= 0),
            fats REAL CHECK (fats >= 0),
            FOREIGN KEY (meal_id) REFERENCES meals(id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE daily_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            workout_id INTEGER,
            meal_id INTEGER,
            calories_consumed REAL CHECK (calories_consumed >= 0),
            calories_burned REAL CHECK (calories_burned >= 0),
            steps INTEGER CHECK (steps >= 0),
            notes TEXT,
            date DATE NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
            FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE SET NULL,
            FOREIGN KEY (meal_id) REFERENCES meals(id) ON DELETE SET NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE sponsors (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            logo_url TEXT,
            website_url TEXT,
            contact_email TEXT,
            sponsorship_type TEXT CHECK (sponsorship_type IN ('financial', 'equipment', 'marketing')) NOT NULL,
            amount REAL DEFAULT NULL,
            start_date DATE NOT NULL,
            end_date DATE NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
          )
        ''');
        await db.execute('''
          CREATE TABLE events (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT,
            date DATE NOT NULL,
            location TEXT NOT NULL,
            organizer_id INTEGER NOT NULL,
            sponsor_id INTEGER NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (organizer_id) REFERENCES users(id) ON DELETE CASCADE,
            FOREIGN KEY (sponsor_id) REFERENCES sponsors(id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE challenges (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT,
            reward TEXT,
            start_date DATE NOT NULL,
            end_date DATE NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
          )
        ''');
      },
    );
  }

  // CRUD Functions
  Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(String table, Map<String, dynamic> data, String where, List<dynamic> whereArgs) async {
    final db = await database;
    await db.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<void> delete(String table, String where, List<dynamic> whereArgs) async {
    final db = await database;
    await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    final db = await database;
    return await db.query(table);

