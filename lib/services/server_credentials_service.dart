import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class ServerCredential {
  final int id;
  final String label;
  final String url;
  final String apiKey;
  final bool inUse;
  final DateTime createdAt;

  const ServerCredential({
    required this.id,
    required this.label,
    required this.url,
    required this.apiKey,
    required this.inUse,
    required this.createdAt,
  });

  static ServerCredential fromRow(Row row) {
    return ServerCredential(
      id: row['id'] as int,
      label: row['label'] as String,
      url: row['url'] as String,
      apiKey: row['api_key'] as String,
      inUse: (row['in_use'] as int) == 1,
      createdAt: DateTime.parse(row['created_at'] as String),
    );
  }
}

class ServerCredentialsService {
  ServerCredentialsService._();

  static final ServerCredentialsService instance =
      ServerCredentialsService._();

  Database? _db;

  Future<String> _resolveDbPath() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      return '${dir.path}${Platform.pathSeparator}n8n_monitor.db';
    } on PlatformException {
      // Fallback when platform channel is not available (e.g. tests, early init)
      return '${Directory.current.path}${Platform.pathSeparator}n8n_monitor.db';
    } on MissingPluginException {
      // Fallback when plugin is not registered
      return '${Directory.current.path}${Platform.pathSeparator}n8n_monitor.db';
    }
  }

  Future<Database> _openDb() async {
    if (_db != null) return _db!;

    final dbPath = await _resolveDbPath();
    final db = sqlite3.open(dbPath);

    db.execute('''
      CREATE TABLE IF NOT EXISTS server_credentials (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        label TEXT NOT NULL,
        url TEXT NOT NULL,
        api_key TEXT NOT NULL,
        in_use INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL DEFAULT (datetime('now'))
      )
    ''');

    _db = db;
    return db;
  }

  Future<void> close() async {
    _db?.dispose();
    _db = null;
  }

  Future<int> insertCredential({
    required String label,
    required String url,
    required String apiKey,
    bool inUse = false,
  }) async {
    final db = await _openDb();

    final existing = db.select(
      'SELECT id FROM server_credentials WHERE api_key = ? LIMIT 1',
      [apiKey],
    );
    if (existing.isNotEmpty) {
      final existingId = existing.first['id'] as int;
      if (inUse) {
        db.execute('BEGIN');
        try {
          db.execute('UPDATE server_credentials SET in_use = 0');
          db.execute(
            'UPDATE server_credentials SET in_use = 1 WHERE id = ?',
            [existingId],
          );
          db.execute('COMMIT');
        } catch (e) {
          db.execute('ROLLBACK');
          rethrow;
        }
      }
      return existingId;
    }

    db.execute('BEGIN');
    try {
      if (inUse) {
        db.execute('UPDATE server_credentials SET in_use = 0');
      }

      final stmt = db.prepare(
        'INSERT INTO server_credentials (label, url, api_key, in_use) VALUES (?, ?, ?, ?)',
      );
      stmt.execute([label, url, apiKey, inUse ? 1 : 0]);
      stmt.dispose();

      final id = db.lastInsertRowId;
      db.execute('COMMIT');
      return id;
    } catch (e) {
      db.execute('ROLLBACK');
      rethrow;
    }
  }

  Future<List<ServerCredential>> getAll() async {
    final db = await _openDb();
    final result = db.select(
      'SELECT id, label, url, api_key, in_use, created_at FROM server_credentials ORDER BY created_at DESC',
    );

    return result.map(ServerCredential.fromRow).toList();
  }

  Future<ServerCredential?> getById(int id) async {
    final db = await _openDb();
    final result = db.select(
      'SELECT id, label, url, api_key, in_use, created_at FROM server_credentials WHERE id = ? LIMIT 1',
      [id],
    );

    if (result.isEmpty) return null;
    return ServerCredential.fromRow(result.first);
  }

  Future<ServerCredential?> getInUse() async {
    final db = await _openDb();
    final result = db.select(
      'SELECT id, label, url, api_key, in_use, created_at FROM server_credentials WHERE in_use = 1 LIMIT 1',
    );

    if (result.isEmpty) return null;
    return ServerCredential.fromRow(result.first);
  }

  Future<void> updateCredential({
    required int id,
    required String label,
    required String url,
    required String apiKey,
    bool? inUse,
  }) async {
    final db = await _openDb();

    db.execute('BEGIN');
    try {
      if (inUse == true) {
        db.execute('UPDATE server_credentials SET in_use = 0');
      }

      final stmt = db.prepare(
        'UPDATE server_credentials SET label = ?, url = ?, api_key = ?, in_use = COALESCE(?, in_use) WHERE id = ?',
      );
      stmt.execute([label, url, apiKey, inUse == null ? null : (inUse ? 1 : 0), id]);
      stmt.dispose();

      db.execute('COMMIT');
    } catch (e) {
      db.execute('ROLLBACK');
      rethrow;
    }
  }

  Future<void> setInUse(int id) async {
    final db = await _openDb();
    db.execute('BEGIN');
    try {
      db.execute('UPDATE server_credentials SET in_use = 0');
      db.execute('UPDATE server_credentials SET in_use = 1 WHERE id = ?', [id]);
      db.execute('COMMIT');
    } catch (e) {
      db.execute('ROLLBACK');
      rethrow;
    }
  }

  Future<void> deleteCredential(int id) async {
    final db = await _openDb();
    db.execute('DELETE FROM server_credentials WHERE id = ?', [id]);
  }
}
