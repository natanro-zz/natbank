import 'dart:async';

import 'package:flutter/material.dart';
import 'package:natbank/http/webclients/natbank_server.dart';
import 'package:natbank/http/webclients/transactions_webclient.dart';
import 'package:natbank/models/contact.dart';
import 'package:natbank/models/response_dialog.dart';
import 'package:natbank/models/transaction.dart';
import 'package:natbank/models/transaction_auth_dialog.dart';
import 'package:natbank/widgets/app_dependencies.dart';
import 'package:natbank/widgets/progress.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String _transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
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
              Visibility(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Progress(
                    label: 'Enviando...',
                  ),
                ),
                visible: _sending,
              ),
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
                      final transactionCreated = Transaction(
                        _transactionId,
                        value,
                        widget.contact,
                      );
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                                onConfirm: (String password) => _save(
                                    dependencies.transactionsWebClient,
                                    transactionCreated,
                                    password,
                                    context));
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
    TransactionsWebClient webClient,
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    Transaction transaction =
        await _send(webClient, transactionCreated, password, context);

    _showSuccessDialog(context, transaction);
  }

  Future _showSuccessDialog(
      BuildContext context, Transaction transaction) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog(message: 'transação enviada');
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction> _send(
      TransactionsWebClient webClient,
      Transaction transactionCreated,
      String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });
    final Transaction transaction =
        await webClient.save(transactionCreated, password).catchError((e) {
      _showFailureDialog(context, message: e.toString());
    }, test: (e) => e is NatbankException).catchError((e) {
      _showFailureDialog(context, message: 'Tempo de conexão esgotado');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureDialog(context);
    }, test: (e) => e is Exception).whenComplete(() => {
              setState(() {
                _sending = false;
              })
            });
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
