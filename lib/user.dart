import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class User {
  final int id;
  final String name;
  final String email;
  double balance;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.balance,
  });

  static Future<List<User>> getUsers() async {
    Database db = await DatabaseHelper.database;
    List<Map<String, dynamic>> userMaps = await db.query('users');

    return userMaps.map((userMap) {
      return User(
        id: userMap['id'] as int,
        name: userMap['name'] as String,
        email: userMap['email'] as String,
        balance: (userMap['balance'] as num).toDouble(),
      );
    }).toList();
  }

  Future<void> updateUserBalance(double newBalance) async {
    Database db = await DatabaseHelper.database;
    await db.update(
      'users',
      {'balance': newBalance},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static User empty() {
    return User(id: -1, name: '', email: '', balance: 0.0);
  }
}
