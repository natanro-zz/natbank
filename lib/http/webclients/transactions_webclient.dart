import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:natbank/http/interceptors/logging_interceptor.dart';
import 'package:natbank/models/transaction.dart';

class TransactionsWebClient {
  static const String _baseUrl = 'http://192.168.0.103:8080/transactions';
  final Client _client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()], requestTimeout: Duration(seconds: 7));
  static final Map<int, String> _httpStatusCodeResponse = {
    400 : "erro ao submeter a transação",
    401 : "falha na autenticação",
  };

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

    throw HttpException(_httpStatusCodeResponse[response.statusCode]);
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
