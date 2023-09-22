import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' as sql;

class UserDatabaseHelper {
  static const tableName = "users";
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstName TEXT NOT NULL,
            lastName TEXT NOT NULL,
            email TEXT NOT NULL,
            phoneNumber TEXT NOT NULL,
            password TEXT NOT NULL,
            token TEXT,
            createdAt INTEGER NOT NULL,
            updatedAt INTEGER NOT NULL
          );
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'user.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new user
  static Future<bool> createItem(user) async {
    final db = await UserDatabaseHelper.db();

    try {
      final id = await db.insert(tableName, user,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', "$id");
      return true;
    } catch (e) {
      return false;
    }
  }

  // Read all it
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await UserDatabaseHelper.db();
    return db.query(tableName, orderBy: "id");
  }

  // Get a single user by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await UserDatabaseHelper.db();
    return db.query(tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

//Sign in
  static Future<List<Map<String, dynamic>>> signIn(
    String email,
    String password,
  ) async {
    final db = await UserDatabaseHelper.db();
    final user = await db.query(tableName,
        where: "email = ? AND password = ?",
        whereArgs: [email, password],
        limit: 1);

    return user;
  }

  // Update a wallet record
  static Future<int> updateUser(int id, String password) async {
    final db = await UserDatabaseHelper.db();
    return await db.update(tableName, {"password": password},
        where: "id = ?", whereArgs: [id]);
  }
}
