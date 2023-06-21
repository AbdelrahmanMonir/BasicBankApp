import 'package:flutter/material.dart';
import 'user.dart';
import 'transfer.dart';

class TransferScreen extends StatelessWidget {
  final User sender;
  final TextEditingController amountController = TextEditingController();

  TransferScreen({required this.sender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer Money')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sender: ${sender.name}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String amountText = amountController.text.trim();
                if (amountText.isNotEmpty) {
                  double amount = double.parse(amountText);
                  User? receiver;

                  if (amount > 0 && amount <= sender.balance) {
                    List<User> users = await User.getUsers();
                    users.remove(sender);

                    receiver = await showDialog<User>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Select Receiver'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: users.map((user) {
                              return ListTile(
                                title: Text(user.name),
                                subtitle: Text(user.email),
                                onTap: () {
                                  Navigator.pop(context, user);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid amount or insufficient balance'),
                      ),
                    );
                  }

                  if (receiver != null) {
                    await Transfer.saveTransfer(
                      senderId: sender.id,
                      receiverId: receiver.id,
                      amount: amount,
                    );

                    double senderNewBalance = sender.balance - amount;
                    await sender.updateUserBalance(senderNewBalance);

                    double receiverNewBalance = receiver.balance + amount;
                    await receiver.updateUserBalance(receiverNewBalance);

                    sender.balance = senderNewBalance;
                    receiver.balance = receiverNewBalance;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Money transferred successfully'),
                      ),
                    );

                    Navigator.pop(context);
                  }
                }
              },

              child: Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}
