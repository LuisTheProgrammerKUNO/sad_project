import 'dart:io' show Platform;  // For platform detection
import 'package:flutter/foundation.dart' show kIsWeb;  // To detect if it's running on the web
import 'package:sqflite_common_ffi/sqflite_ffi.dart';  // Import for desktop or FFI support
import 'package:shared_preferences/shared_preferences.dart'; // For web storage
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class UserRepository {
  static final UserRepository _instance = UserRepository.internal();
  factory UserRepository() => _instance;

  static Database? _db;

  UserRepository.internal() {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;  // Set the database factory for FFI
    }
  }

  Future<Database?> get db async {
    if (kIsWeb) {
      return null;  // No SQLite database on the web
    }
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');

    // Delete the old database for testing purposes
    await deleteDatabase(path); // Comment or remove this line in production

    return await openDatabase(
      path,
      version: 3, // Incremented version to force schema update
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 3) {
          await db.execute('ALTER TABLE users ADD COLUMN email TEXT UNIQUE');
        }
      },
    );
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<int> registerUser(String name, String email, String password) async {
    if (kIsWeb) {
      // Web version using shared_preferences
      final prefs = await SharedPreferences.getInstance();
      String hashedPassword = _hashPassword(password);

      if (prefs.containsKey(email)) {
        throw Exception('Email already exists');
      }

      await prefs.setString(email, jsonEncode({'name': name, 'password': hashedPassword}));
      return 1;  // Returning 1 as a success code
    } else {
      var dbClient = await db;

      if (dbClient != null) {
        try {
          // Check if the email already exists in the database
          List<Map<String, dynamic>> existingUsers = await dbClient.query(
            'users',
            where: 'email = ?',
            whereArgs: [email],
          );

          if (existingUsers.isNotEmpty) {
            // Throw an exception if email already exists
            throw Exception('Email already exists');
          }

          String hashedPassword = _hashPassword(password);

          // Insert new user into the database
          return await dbClient.insert(
            'users',
            {
              'name': name,
              'email': email,
              'password': hashedPassword,
            },
          );
        } catch (e) {
          print("Error in registerUser: $e"); // Print error for debugging
          rethrow; // Re-throw to handle in the UI
        }
      }
      throw Exception('Database not available');
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    String hashedPassword = _hashPassword(password);

    if (kIsWeb) {
      // Web version using shared_preferences
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(email)) {
        final userJson = prefs.getString(email);
        if (userJson != null) {
          final user = jsonDecode(userJson);
          if (user['password'] == hashedPassword) {
            return {'name': user['name'], 'email': email};
          }
        }
      }
      return null;  // Invalid login
    } else {
      var dbClient = await db;
      if (dbClient != null) {
        List<Map<String, dynamic>> users = await dbClient.query(
          'users',
          where: 'email = ? AND password = ?',
          whereArgs: [email, hashedPassword],
        );

        return users.isNotEmpty ? users.first : null;
      }
      throw Exception('Database not available');
    }
  }
}
