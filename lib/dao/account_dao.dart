import 'package:natbank/database/app_database.dart';
import 'package:natbank/models/account.dart';
import 'package:sqflite/sqflite.dart';

class AccountDAO {
  static const String _tableName = 'account';
  static const String _id = "id";
  static const String _agency = "agency";
  static const String _number = "number";
  static const String _balance = "balance";

  Future<void> save(Account account) async {
    final Database db =
        await getDatabase(tableName: _tableName);
    Map<String, dynamic> accountMap = _getAccountMap(account);
    await db.insert(_tableName, accountMap);
    await db.close();
  }

  Map<String, dynamic> _getAccountMap(Account account) => {
        _id: account.id,
        _number: account.number,
        _agency: account.agency,
        _balance: account.balance
      };
}
