import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase(String tableSql, int version) async {
  final String path = join(await getDatabasesPath(), 'natbank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(tableSql);
    },
    version: version, /*onDowngrade: onDatabaseDowngradeDelete*/
  );
}
