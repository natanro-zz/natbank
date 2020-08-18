import 'package:natbank/database/app_database.dart';
import 'package:natbank/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDAO {
  static const String _tableName = 'user';
  static const String _id = "id";
  static const String _firstName = "firstName";
  static const String _lastName = "lastName";
  static const String _cpf = "cpf";
  static const String _password = "password";
  static const String _email = "email";

  Future<void> save(User user) async {
    final Database db =
        await getDatabase(tableName: _tableName);
    Map<String, dynamic> userMap = _getUserMap(user);
    await db.insert(_tableName, userMap);
    await db.close();
  }

  Map<String, dynamic> _getUserMap(User user) {
    Map<String, dynamic> userMap = Map();
    userMap[_id] = user.id;
    userMap[_firstName] = user.firstName;
    userMap[_lastName] = user.lastName;
    userMap[_cpf] = user.cpf;
    userMap[_password] = user.password;
    userMap[_email] = user.email;
    return userMap;
  }

  Future<bool> validate(String cpf, String password) async {
    final Database db =
        await getDatabase(tableName: _tableName);
    List<Map<String, dynamic>> userMap = await db.query(
      _tableName,
      where: "$_cpf = ?",
      whereArgs: [cpf],
    );

    bool validUser = false;
    userMap.forEach((element) {
      if (element.values.contains(cpf)) {
        if (element.values.contains(password)) {
          validUser = true;
        }
      }
    });

    return (validUser == true) ? true : throw UserDaoException("CPF ou Senha inválidos");
  }
}

class UserDaoException implements Exception {
  final String message;

  UserDaoException(this.message);
}
