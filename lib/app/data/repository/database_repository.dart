import 'package:path/path.dart';
import 'package:sana/app/data/models/message_model.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._privatevateConstructor();

  static final AppDatabase instance = AppDatabase._privatevateConstructor();

  Database? _database;
  static const String _tableName = 'messages';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    // Get the standard directory for the database
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'app_database.db');

    // Open the database and define the schema
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL
      )
    ''');
  }

  // POST (Insert): Add a new record
  Future<int> insertMessage(MessageModel message) async {
    Database db = await instance.database;
    // ConflictAlgorithm.replace ensures that if the same ID is inserted, it updates the existing row
    return await db.insert(
      _tableName,
      message.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // LOAD (Read): Fetch all records
  Future<List<MessageModel>> getMessage() async {
    Database db = await instance.database;

    // Query the table for all notes
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'id DESC', // Industry standard to show newest first
    );

    // Convert the List<Map<String, dynamic> into a List<Note>
    return List.generate(maps.length, (i) {
      return MessageModel.fromJson(maps[i]);
    });
  }

  // Optional but recommended: Resource cleanup
  Future close() async {
    Database db = await instance.database;
    db.close();
  }
}
