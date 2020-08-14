import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase(
    {@required String tableName}) async {
  final   List<String> onCreateSQL = [
    'CREATE TABLE user (id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, cpf TEXT, password TEXT, email TEXT)',
    'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, account_number INTEGER)',
    'CREATE TABLE account (id INTEGER PRIMARY KEY, number INTEGER, agency TEXT, balance REAL)',
  ];
  final String path = join(await getDatabasesPath(), 'natbank.db');
  final int version = 1;
  return openDatabase(
    path,
    onCreate: (db, version) {
      onCreateSQL.forEach((element) async => await db.execute(element));
    },
    onUpgrade: (db, oldVersion, newVersion) =>
        'DROP TABLE IF EXISTS $tableName',
    version: version,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
