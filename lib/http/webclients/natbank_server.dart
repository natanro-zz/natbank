import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:natbank/http/interceptors/logging_interceptor.dart';


class NatbankServer {
  static final String _baseUrl = 'http://192.168.0.109:8080';
  static final Client _client =
  HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()], requestTimeout: Duration(seconds: 7));

  static String get baseUrl => _baseUrl;
  static Client get client => _client;
}

class NatbankException implements Exception {
  String _message;
  static final Map<int, String> _httpStatusCodeResponse = {
    400 : "Requisição incompleta",
    401 : "Falha na autenticação",
  };

  NatbankException({String message, int statusCode}) {
    if (_httpStatusCodeResponse.containsKey(statusCode)) this._message = _httpStatusCodeResponse[statusCode];
    else this._message = message;
  }

  @override
  String toString() {
    return this._message;
  }
}