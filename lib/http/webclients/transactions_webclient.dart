import 'dart:convert';

import 'package:http/http.dart';
import 'package:natbank/http/webclients/natbank_server.dart';
import 'package:natbank/models/transaction.dart';

class TransactionsWebClient {
  final _client = NatbankServer.client;
  final _baseUrl = NatbankServer.baseUrl;

  Future<List<Transaction>> findAll() async {
    final Response response =
        await _client.get(_baseUrl).timeout(Duration(seconds: 15));
    List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await _client.post(
      _baseUrl,
      headers: {'Content-type': 'application/json', 'password': password},
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw NatbankException(message: jsonDecode(response.body), statusCode: response.statusCode);
  }
}
