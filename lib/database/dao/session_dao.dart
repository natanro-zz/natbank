import 'package:natbank/database/app_database.dart';
import 'package:natbank/services/session.dart';
import 'package:sqflite/sqflite.dart';

class SessionDAO {
  static final String _tableName = 'session';
  static final String _id = 'id';
  static final String _duration = 'duration';
  static final String _loggedAt = 'loggedAt';

  Future<void> save(Session authenticationToken) async {
    final Database db = await getDatabase(tableName: _tableName);
    Map<String, dynamic> authMap = _getAuthMap(authenticationToken);
    await db.insert(_tableName, authMap);
    await db.close();
  }

  Map<String, dynamic> _getAuthMap(Session authenticationToken) => {
        _id: authenticationToken.id,
        _duration: authenticationToken.duration.inSeconds,
        _loggedAt : authenticationToken.loggedAt,
      };

  Future<Map<String, dynamic>> find() async {
    final Database db = await getDatabase(tableName: _tableName);
    final List<Map<String, dynamic>> table = await db.query(_tableName,
        columns: [_id, _duration, _loggedAt], where: '$_id = ?', whereArgs: [1]);
    await db.close();

    if (table.isNotEmpty)
      return table[0];
    else
      return Map<String, dynamic>();
  }
}
