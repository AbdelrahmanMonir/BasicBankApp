import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  static Future<Database> initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'banking_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, balance REAL)');
        await db.execute('CREATE TABLE transfers(sender_id INTEGER, receiver_id INTEGER, amount REAL)');
        await db.insert(
          'users',
          {'id': 1, 'name': 'John Doe', 'email': 'john.doe@gmail.com', 'balance': 50000.0},
        );
        await db.insert(
          'users',
          {'id': 2, 'name': 'Jane Smith', 'email': 'jane.smith@hotmail.com', 'balance': 30000.0},
        );
        await db.insert(
          'users',
          {'id': 3, 'name': 'David Johnson', 'email': 'david.johnson@hotmail.com', 'balance': 20000.0},
        );
        await db.insert(
          'users',
          {'id': 4, 'name': 'Mike Batson', 'email': 'mike.batson@gmail.com', 'balance': 90000.0},
        );
        await db.insert(
          'users',
          {'id': 5, 'name': 'Jonah Jameson', 'email': 'jonah.jameson@hotmail.com', 'balance': 40000.0},
        );
        await db.insert(
          'users',
          {'id': 6, 'name': 'Steven Grant', 'email': 'steven.grant@gmail.com', 'balance': 65000.0},
        );
        await db.insert(
          'users',
          {'id': 7, 'name': 'Gwen Watson', 'email': 'gwen.watson@hotmail.com', 'balance': 80000.0},
        );
        await db.insert(
          'users',
          {'id': 8, 'name': 'Carl Johnson', 'email': 'carl.johnson@gmail.com', 'balance': 32000.0},
        );
        await db.insert(
          'users',
          {'id': 9, 'name': 'Kelly Kent', 'email': 'kelly.kent@hotmail.com', 'balance': 30000.0},
        );
        await db.insert(
          'users',
          {'id': 10, 'name': 'Barbra Jones', 'email': 'barbra.jones@gmail.com', 'balance': 45000.0},
        );
      },
    );
  }
}
