import 'package:natbank/dao/auth_token_dao.dart';

class AuthenticationToken {
  static final int _id = 1;
  static final Duration _duration = Duration(seconds: 1800);
  DateTime _loggedAt;

  AuthenticationToken({DateTime dateTime}) {
    if (dateTime != null) {
      _loggedAt = dateTime;
    }
  }

  Duration get duration => _duration;

  int get id => _id;

  String get loggedAt => _loggedAt?.toIso8601String();

  Future<bool> isUserAuthenticated() async {
    final dao = AuthenticationTokenDAO();
    Map<String, dynamic> authMap = await dao.find();

    bool isAuthenticated = false;
    if (authMap.containsKey('loggedAT')) {
      _loggedAt = DateTime.parse(authMap['loggedAt']);
      DateTime now = DateTime.now();
      if (now.difference(_loggedAt) < _duration) isAuthenticated = true;
    }
    return isAuthenticated;
  }
}
