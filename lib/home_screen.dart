import 'package:flutter/material.dart';
import 'main.dart';
import 'user.dart';
import 'view_user_screen.dart';
import 'transfers_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Basic Banking App')),
      body: FutureBuilder<List<User>>(
        future: User.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> users = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: users.map((user) {
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewUserScreen(user: user),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error loading users');
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransfersScreen(),
            ),
          );
        },
        child: Icon(Icons.history),
      ),
    );
  }
}

void main() {
  runApp(BankingApp());
}
