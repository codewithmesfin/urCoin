import 'package:sqflite/sqflite.dart' as sql;

class WalletDatabaseHelper {
  static const tableName = "wallet";

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER NOT NULL,
            key TEXT NOT NULL,
            address TEXT NOT NULL,
            name TEXT NOT NULL,
            createdAt INTEGER NOT NULL,
            updatedAt INTEGER NOT NULL
          );
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'wallet.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create a new wallet record
  static Future<List<Map<String, dynamic>>> createItem(
      Map<String, dynamic> wallet) async {
    final db = await WalletDatabaseHelper.db();

    try {
      await db.insert(tableName, wallet,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);

      return db
          .query(tableName, where: "userId = ?", whereArgs: [wallet["userId"]]);
    } catch (e) {
      return [];
    }
  }

  // Read all wallet records
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await WalletDatabaseHelper.db();
    final wallet = await db.query(tableName, orderBy: "id");
    // print(wallet);
    return wallet;
  }

  // Get a single wallet record by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await WalletDatabaseHelper.db();
    return db.query(tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Get wallet records by userId
  static Future<List<Map<String, dynamic>>> getWalletByUserId(
      int userId) async {
    final db = await WalletDatabaseHelper.db();
    return db.query(tableName, where: "userId = ?", whereArgs: [userId]);
  }

  // Update a wallet record
  static Future<int> updateItem(Map<String, dynamic> wallet) async {
    final db = await WalletDatabaseHelper.db();
    return await db
        .update(tableName, wallet, where: "id = ?", whereArgs: [wallet['id']]);
  }

  // Delete a wallet record
  static Future<List<Map<String, dynamic>>> deleteItem(int id, userId) async {
    final db = await WalletDatabaseHelper.db();
    await db.delete(tableName, where: "id = ?", whereArgs: [id]);

    return db.query(tableName, where: "userId = ?", whereArgs: [userId]);
  }
}
