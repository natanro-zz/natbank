import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:natbank/http/webclients/natbank_server.dart';
import 'package:natbank/models/user_form.dart';
import 'package:natbank/models/account.dart';

class AccountWebClient {
  final _client = NatbankServer.client;
  final _baseUrl = NatbankServer.baseUrl+'/account/new';

  Future<Account> save(UserForm userForm) async {
    String body = jsonEncode(userForm.toJson());

    Response response = await _client.post(
      _baseUrl,
      headers: {"Content-type": "application/json"},
      body: body,
    );

    debugPrint("Status: "+response.statusCode.toString());
    debugPrint("Headers: "+response.headers.toString());
    debugPrint("Body: "+response.body);

    if (response.statusCode == 201) {
      return Account.fromJson(jsonDecode(response.body));
    }

    throw NatbankException(message: response.body, statusCode: response.statusCode);
  }
}
