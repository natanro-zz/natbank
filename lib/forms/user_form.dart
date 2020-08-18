import 'package:flutter/material.dart';
import 'package:natbank/models/user.dart';

class UserForm {
  final String firstName;
  final String lastName;
  final String cpf;
  final String email;
  final String password;

  UserForm({
    @required this.firstName,
    @required this.lastName,
    @required this.cpf,
    @required this.email,
    @required this.password,
  });

  @override
  String toString() {
    return "UserForm {firstName: ${this.firstName} lastName: ${this.lastName} cpf: ${this.cpf} email: ${this.email}" +
        "password: ${this.password}}";
  }

  Map<String, String> toJson() => {
        "name": this.firstName + " " + this.lastName,
        "email": this.email,
        "cpf": this.cpf,
        "password": this.password
      };

  User toUser(int id) {
    User user = User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        cpf: cpf,
        email: email,
        password: password);
    return user;
  }
}
