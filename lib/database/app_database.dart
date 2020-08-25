import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase({@required String tableName, int version}) async {
  final List<String> tables = [
    'CREATE TABLE user (id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, cpf TEXT, password TEXT, email TEXT)',
    'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, account_number INTEGER)',
    'CREATE TABLE account (id INTEGER PRIMARY KEY, number INTEGER, agency TEXT, balance REAL)',
    'CREATE TABLE session (id INTEGER PRIMARY KEY, duration INTEGER, loggedAt TEXT)'
  ];
  final String path = join(await getDatabasesPath(), 'natbank.db');
  final int _version = (version != null && version != 1) ? version : 1;
  return openDatabase(
    path,
    onCreate: (db, version) {
      tables.forEach((table) async => await db.execute(table));
    },
    onUpgrade: (db, oldVersion, newVersion) =>
        'DROP TABLE IF EXISTS $tableName',
    version: _version,
  );
}
