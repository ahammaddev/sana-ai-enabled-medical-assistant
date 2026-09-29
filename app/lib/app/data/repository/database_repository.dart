import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sana/app/data/models/consultation_model.dart';
import 'package:sana/app/data/models/message_model.dart';

class AppDatabase {
  AppDatabase._privateConstructor();

  static final AppDatabase instance = AppDatabase._privateConstructor();

  Database? _database;
  static const String _tableName = 'messages';
  static const String _conversationsTable = 'conversations';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_conversationsTable (
        id TEXT PRIMARY KEY,
        title TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        lastMessage TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sessionId TEXT,
        userMessage TEXT,
        message TEXT,
        status TEXT,
        bottimestamp TEXT,
        usertimestamp TEXT
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_conversationsTable (
          id TEXT PRIMARY KEY,
          title TEXT,
          createdAt TEXT,
          updatedAt TEXT,
          lastMessage TEXT
        )
      ''');

      var columns = await db.rawQuery('PRAGMA table_info($_tableName)');
      bool hasSessionId = columns.any((c) => c['name'] == 'sessionId');
      if (!hasSessionId) {
        await db.execute('ALTER TABLE $_tableName ADD COLUMN sessionId TEXT');
      }

      // Group existing messages into a legacy conversation if any exist
      final existingMsgs = await db.query(
        _tableName,
        where: 'sessionId IS NULL',
      );
      if (existingMsgs.isNotEmpty) {
        final firstMsg = existingMsgs.first;
        String rawTitle =
            firstMsg['userMessage'] as String? ?? 'Previous Consultation';
        String title = rawTitle.length > 35
            ? '${rawTitle.substring(0, 35)}...'
            : rawTitle;
        final now = DateTime.now().toIso8601String();

        await db.insert(_conversationsTable, {
          'id': 'legacy_session',
          'title': title,
          'createdAt': now,
          'updatedAt': now,
          'lastMessage': firstMsg['userMessage'] as String? ?? '',
        });

        await db.rawUpdate(
          'UPDATE $_tableName SET sessionId = ? WHERE sessionId IS NULL',
          ['legacy_session'],
        );
      }
    }
  }

  // --- CONVERSATION OPERATIONS ---

  Future<List<ConsultationModel>> getConversations() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _conversationsTable,
      orderBy: 'updatedAt DESC',
    );

    return List.generate(maps.length, (i) {
      return ConsultationModel.fromJson(maps[i]);
    });
  }

  Future<ConsultationModel?> getConversation(String sessionId) async {
    Database db = await database;
    final maps = await db.query(
      _conversationsTable,
      where: 'id = ?',
      whereArgs: [sessionId],
      limit: 1,
    );
    return maps.isEmpty ? null : ConsultationModel.fromJson(maps.first);
  }

  Future<int> insertConversation(ConsultationModel conversation) async {
    Database db = await database;
    return await db.insert(
      _conversationsTable,
      conversation.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateConversation(ConsultationModel conversation) async {
    Database db = await database;
    return await db.update(
      _conversationsTable,
      conversation.toJson(),
      where: 'id = ?',
      whereArgs: [conversation.id],
    );
  }

  Future<void> deleteConversation(String sessionId) async {
    Database db = await database;
    await db.delete(
      _conversationsTable,
      where: 'id = ?',
      whereArgs: [sessionId],
    );
    await db.delete(_tableName, where: 'sessionId = ?', whereArgs: [sessionId]);
  }

  Future<void> clearAllConversations() async {
    Database db = await database;
    await db.delete(_conversationsTable);
    await db.delete(_tableName);
  }

  Future<bool> hasChatHistory() async {
    Database db = await database;
    final convs = await db.query(_conversationsTable, limit: 1);
    if (convs.isNotEmpty) return true;
    final msgs = await db.query(_tableName, limit: 1);
    return msgs.isNotEmpty;
  }

  // --- MESSAGE OPERATIONS ---

  Future<List<MessageModel>> getMessagesBySession(String sessionId) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'sessionId = ?',
      whereArgs: [sessionId],
      orderBy: 'id DESC', // Newest first
    );

    return List.generate(maps.length, (i) {
      return MessageModel.fromJson(maps[i]);
    });
  }

  Future<int> insertMessage(MessageModel message) async {
    Database db = await database;
    return await db.insert(
      _tableName,
      message.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateMessage(MessageModel message) async {
    Database db = await database;
    return await db.update(
      _tableName,
      message.toJson(),
      where: 'id = ?',
      whereArgs: [message.id],
    );
  }

  Future<int> deleteMessage(MessageModel message) async {
    Database db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [message.id],
    );
  }

  Future<int> clearAllMessages() async {
    Database db = await database;
    return await db.delete(_tableName);
  }

  Future<List<MessageModel>> getMessage() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );

    return List.generate(maps.length, (i) {
      return MessageModel.fromJson(maps[i]);
    });
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}
