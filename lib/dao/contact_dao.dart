import 'package:natbank/database/app_database.dart';
import 'package:natbank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDAO {
  static const String _tableName = 'contacts';
  static const String _tableSql =
      "CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, name TEXT, account_number INTEGER)";
  static const String _id = "id";
  static const String _name = "name";
  static const String _accountNumber = "account_number";
  static const int _dbVersion = 1;

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase(_tableSql, _dbVersion);
    Map<String, dynamic> contactMap = _getContactMap(contact);
    Future<int> insertedId = db.insert(_tableName, contactMap);
    await db.close();
    return insertedId;
  }

  Map<String, dynamic> _getContactMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase(_tableSql, _dbVersion);
    List<Map<String, dynamic>> table = await db.query(_tableName);
    await db.close();
    List<Contact> contacts = _getContactList(table);
    return contacts;
  }

  List<Contact> _getContactList(List<Map<String, dynamic>> table) {
    final List<Contact> contacts = List();
    for (Map<String, dynamic> row in table) {
      final Contact contact =
          Contact(row[_id], row[_name], row[_accountNumber]);
      contacts.add(contact);
    }
    return contacts;
  }
}
