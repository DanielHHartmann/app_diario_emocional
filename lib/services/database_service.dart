import 'dart:developer';

import 'package:diario_emocional/data/emotion.dart';
import 'package:diario_emocional/data/model/journal_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'journal.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE journal_entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            emotion TEXT NOT NULL,
            note TEXT,
            timestamp TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertEntry(JournalEntry entry) async {
    final database = await db;
    await database.insert(
      'journal_entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<JournalEntry>> getEntriesForDate(DateTime date) async {
    final dbInstance = await db;
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));

    final result = await dbInstance.query(
      'journal_entries',
      where: 'timestamp >= ? AND timestamp < ?',
      whereArgs: [
        start.toIso8601String(),
        end.toIso8601String(),
      ],
      orderBy: 'timestamp DESC',
    );

    return result.map((e) => JournalEntry.fromMap(e)).toList();
  }

  Future<List<JournalEntry>> getAllEntries() async {
    final dbInstance = await db;
    final result = await dbInstance.query('journal_entries', orderBy: 'timestamp DESC');
    return result.map((e) => JournalEntry.fromMap(e)).toList();
  }
  Future<JournalEntry?> getTodayEntry() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    final dbInstance = await db;
    final result = await dbInstance.query(
      'journal_entries',
      where: 'timestamp >= ? AND timestamp < ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return JournalEntry.fromMap(result.first);
    }
    return null;
  }

  Future<void> updateEntry(JournalEntry entry) async {
    final dbInstance = await db;
    await dbInstance.update(
      'journal_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }
  Future<List<JournalEntry>> getEntriesForLast7Days() async {
    final dbInstance = await db;
    final now = DateTime.now();
    final end = DateTime(now.year, now.month, now.day);
    final start = end.subtract(const Duration(days: 7));
    final result = await dbInstance.query(
      'journal_entries',
      where: 'timestamp >= ? AND timestamp < ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'timestamp ASC',
    );
    return result.map((e) => JournalEntry.fromMap(e)).toList();
  }

  Future<void> deleteAllEntries() async {
    final dbInstance = await db;
    await dbInstance.delete('journal_entries');
    log('🧼 All journal entries deleted.');
  }

}
