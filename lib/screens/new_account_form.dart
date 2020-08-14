import 'dart:async';

import 'package:flutter/material.dart';
import 'package:natbank/http/webclients/natbank_server.dart';
import 'package:natbank/models/account.dart';
import 'package:natbank/models/response_dialog.dart';
import 'package:natbank/models/user_form.dart';
import 'package:natbank/widgets/app_dependencies.dart';

import 'login.dart';

// TODO: possivelmente mudar para Statefull para mostrar widget de loading

class NewAccount extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ClipPath(
                clipper: LoginClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/natbank_lightBlue500.png'),
                        fit: BoxFit.cover),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 150, bottom: 100),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Primeiro nome",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              LoginInputField(
                hintText: "Digite seu nome",
                icon: Icons.text_fields,
                controller: _firstNameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Sobrenome",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              LoginInputField(
                hintText: "Digite seu sobrenome",
                icon: Icons.text_fields,
                controller: _lastNameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "CPF",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              LoginInputField(
                hintText: "Digite seu CPF",
                icon: Icons.person_outline,
                controller: _cpfController,
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "E-mail",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              LoginInputField(
                hintText: "Digite seu E-mail",
                icon: Icons.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Senha",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              LoginInputField(
                hintText: "Cadastre sua senha",
                icon: Icons.lock_open,
                controller: _passwordController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              NewAccountButton(
                buttonText: "Cadastrar",
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                cpfController: _cpfController,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewAccountButton extends StatelessWidget {
  final String buttonText;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  NewAccountButton({
    @required this.buttonText,
    @required this.firstNameController,
    @required this.lastNameController,
    @required this.cpfController,
    @required this.emailController,
    @required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              splashColor: Colors.lightBlue,
              color: Colors.lightBlue,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      this.buttonText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Transform.translate(
                    offset: Offset(15, 0),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28)),
                        splashColor: Colors.white,
                        color: Colors.white,
                        child: Icon(
                          Icons.check,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: () =>
                            _registerNewUser(dependencies, context),
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () => _registerNewUser(dependencies, context),
            ),
          )
        ],
      ),
    );
  }

  Future _registerNewUser(
      AppDependencies dependencies, BuildContext context) async {
    {
      UserForm userForm = UserForm(
        firstName: this.firstNameController.text,
        lastName: this.lastNameController.text,
        cpf: this.cpfController.text,
        email: this.emailController.text,
        password: this.passwordController.text,
      );
      Account newAccount = await _createAccount(context, userForm, dependencies);
      if (newAccount != null) {
        await dependencies.accountDAO.save(newAccount);
        await dependencies.userDAO.save(userForm.toUser(newAccount.id));
        await showDialog(
            context: context,
            builder: (dialogContext) {
              return SuccessDialog(message: 'Conta criada!');
            });
        Navigator.pop(context);
      }
    }
  }

  Future<Account> _createAccount(BuildContext context,
      UserForm userForm, AppDependencies dependencies) async {
    Account account =
        await dependencies.accountWebClient.save(userForm).catchError((e) {
      _showFailureDialog(context, message: e.toString());
    }, test: (e) => e is NatbankException).catchError((e) {
      _showFailureDialog(context, message: "Tempo de conexão esgotado");
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureDialog(context);
    }, test: (e) => e is Exception);
    return account;
  }

  void _showFailureDialog(BuildContext context, {String message = "Erro desconhecido"}) {
    showDialog(context: context, builder: (dialogContext) {
      return FailureDialog(message: message);
    });
  }
}
