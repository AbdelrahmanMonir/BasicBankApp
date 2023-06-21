import 'package:flutter/material.dart';
import 'transfer.dart';

class TransfersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer History')),
      body: FutureBuilder<List<Transfer>>(
        future: Transfer.getTransfers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Transfer> transfers = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: transfers.map((transfer) {
                  return ListTile(
                    title: Text('From: ${transfer.senderName}'),
                    subtitle: Text('To: ${transfer.receiverName}\nAmount: \$${transfer.amount.toStringAsFixed(2)}'),
                  );
                }).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error loading transfer history');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
