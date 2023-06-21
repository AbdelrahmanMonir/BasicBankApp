import 'package:flutter/material.dart';
import 'user.dart';
import 'transfer_screen.dart';

class ViewUserScreen extends StatelessWidget {
  final User user;

  ViewUserScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Email: ${user.email}'),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Current Balance: \$${user.balance.toStringAsFixed(2)}'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferScreen(
                      sender: user,
                    ),
                  ),
                );
              },
              child: Text('Transfer Money'),
            ),
          ],
        ),
      ),
    );
  }
}
