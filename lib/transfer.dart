import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class Transfer {
  final int senderId;
  final int receiverId;
  final double amount;
  String senderName;
  String receiverName;

  Transfer({
    required this.senderId,
    required this.receiverId,
    required this.amount,
    required this.senderName,
    required this.receiverName,
  });

  static Future<List<Transfer>> getTransfers() async {
    Database db = await DatabaseHelper.database;
    List<Map<String, dynamic>> transferMaps = await db.query('transfers');

    return Future.wait(
      transferMaps.map((transferMap) async {
        int senderId = transferMap['sender_id'];
        int receiverId = transferMap['receiver_id'];
        double amount = transferMap['amount'];

        String senderName = await getUserName(senderId);
        String receiverName = await getUserName(receiverId);

        return Transfer(
          senderId: senderId,
          receiverId: receiverId,
          amount: amount,
          senderName: senderName,
          receiverName: receiverName,
        );
      }),
    );
  }

  static Future<String> getUserName(int userId) async {
    Database db = await DatabaseHelper.database;
    List<Map<String, dynamic>> userMaps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    return userMaps.isNotEmpty ? userMaps.first['name'] : '';
  }

  static Future<void> saveTransfer({
    required int senderId,
    required int receiverId,
    required double amount,
  }) async {
    Database db = await DatabaseHelper.database;
    await db.insert(
      'transfers',
      {
        'sender_id': senderId,
        'receiver_id': receiverId,
        'amount': amount,
      },
    );
  }
}
