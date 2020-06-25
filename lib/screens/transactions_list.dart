import 'package:flutter/material.dart';
import 'package:natbank/http/webclients/transactions_webclient.dart';
import 'package:natbank/models/transaction.dart';
import 'package:natbank/widgets/centered_message.dart';
import 'package:natbank/widgets/progress.dart';

class TransactionsList extends StatelessWidget {
  final TransactionsWebClient _webClient = TransactionsWebClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Feed de Transações'),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: _webClient.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transaction> transactions = snapshot.data;
                  if (transactions.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.contact.accountNumber.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    );
                  }
                  return CenteredMessage(
                    'Não há transações',
                    icon: Icons.warning,
                  );
                }
                return CenteredMessage('Servidor fora do ar', icon: Icons.cloud_off);
                break;
            }
            return CenteredMessage('Unknown error', icon: Icons.error);
          },
        ));
  }
}
