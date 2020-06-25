import 'dart:async';

import 'package:flutter/material.dart';
import 'package:natbank/http/webclients/transactions_webclient.dart';
import 'package:natbank/models/contact.dart';
import 'package:natbank/models/response_dialog.dart';
import 'package:natbank/models/transaction.dart';
import 'package:natbank/models/transaction_auth_dialog.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionsWebClient _webClient = TransactionsWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transferir'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(value, widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                                onConfirm: (String password) => _save(
                                    transactionCreated, password, context));
                          });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    Transaction transaction =
        await _send(transactionCreated, password, context);

    if (transaction != null) {
      _showSuccessDialog(context);
      Navigator.pop(context);
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return SuccessDialog(message: 'transação enviada');
        });
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    final Transaction transaction =
        await _webClient.save(transactionCreated, password).catchError((e) {
      _showFailureDialog(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureDialog(context, message: 'tempo de conexão esgotado');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureDialog(context);
    }, test: (e) => e is Exception);
    return transaction;
  }

  void _showFailureDialog(BuildContext context,
      {String message = "Unknown error"}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message: message);
        });
  }
}
