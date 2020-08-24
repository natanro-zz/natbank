import 'dart:async';

import 'package:flutter/material.dart';
import 'package:natbank/http/forms/user_form.dart';
import 'package:natbank/http/webclients/natbank_server.dart';
import 'package:natbank/models/account.dart';
import 'package:natbank/widgets/response_dialog.dart';
import 'package:natbank/widgets/app_dependencies.dart';
import 'package:natbank/widgets/progress.dart';

import 'login.dart';
import 'login_input_field.dart';

class NewAccount extends StatefulWidget {
  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _cpfController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _sendingForm = false;

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
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Visibility(
                  visible: _sendingForm,
                  child: Progress(
                    label: 'Criando conta',
                  ),
                ),
              ),
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
              newAccountButton(context,
                  buttonText: 'Cadastrar',
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  cpfController: _cpfController,
                  emailController: _emailController,
                  passwordController: _passwordController),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget newAccountButton(
    BuildContext context, {
    @required String buttonText,
    @required TextEditingController firstNameController,
    @required TextEditingController lastNameController,
    @required TextEditingController cpfController,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
  }) {
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
                      buttonText,
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
                        onPressed: () => _registerNewUser(dependencies, context,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            cpf: cpfController.text,
                            email: emailController.text,
                            password: passwordController.text),
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () => _registerNewUser(dependencies, context,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  cpf: cpfController.text,
                  email: emailController.text,
                  password: passwordController.text),
            ),
          )
        ],
      ),
    );
  }

  Future _registerNewUser(AppDependencies dependencies, BuildContext context,
      {@required String firstName,
      @required String lastName,
      @required String cpf,
      @required String email,
      @required String password}) async {
    {
      UserForm userForm = UserForm(
        firstName: firstName,
        lastName: lastName,
        cpf: cpf,
        email: email,
        password: password,
      );
      Account newAccount =
          await _createAccount(context, userForm, dependencies);
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

  Future<Account> _createAccount(BuildContext context, UserForm userForm,
      AppDependencies dependencies) async {
    setState(() {
      _sendingForm = true;
    });
    Account account =
        await dependencies.accountWebClient.save(userForm).catchError((e) {
      _showFailureDialog(context, message: e.toString());
    }, test: (e) => e is NatbankException).catchError((e) {
      _showFailureDialog(context, message: "Tempo de conexão esgotado");
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureDialog(context);
    }, test: (e) => e is Exception).whenComplete(() {
      setState(() {
        _sendingForm = false;
      });
    });
    return account;
  }

  void _showFailureDialog(BuildContext context,
      {String message = "Erro desconhecido"}) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return FailureDialog(message: message);
        });
  }
}
