import 'package:natbank/database/dao/session_dao.dart';

class Session {
  static final int _id = 1;
  static final Duration _duration = Duration(minutes: 10);
  DateTime _loggedAt;

  Session({DateTime dateTime}) {
    if (dateTime != null) {
      _loggedAt = dateTime;
    }
  }

  Duration get duration => _duration;

  int get id => _id;

  String get loggedAt => _loggedAt?.toIso8601String();

  Future<bool> isUserAuthenticated() async {
    final dao = SessionDAO();
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
