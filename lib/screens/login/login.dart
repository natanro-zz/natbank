import 'package:flutter/material.dart';
import 'package:natbank/screens/login/new_account_form.dart';

import 'login_button.dart';
import 'login_input_field.dart';

class Login extends StatelessWidget {
  final TextEditingController _userCpfFieldController = TextEditingController();
  final TextEditingController _userPasswordFieldController =
      TextEditingController();

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
                        image: AssetImage('images/natbank_logo.png'),
                        fit: BoxFit.cover),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 150, bottom: 100),
                ),
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
                controller: _userCpfFieldController,
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Senha",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              LoginInputField(
                icon: Icons.lock_open,
                hintText: "Digite sua senha",
                controller: _userPasswordFieldController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                obscureText: true,
              ),
              LoginButton(
                buttonIcon: Icons.arrow_forward,
                buttonText: "Entrar",
                cpfController: _userCpfFieldController,
                passwordController: _userPasswordFieldController,
              ),
              CreateAccountButton()
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.center,
                child: Text(
                  "ABRIR UMA NOVA CONTA",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (routeContext) => NewAccount())),
            ),
          )
        ],
      ),
    );
  }
}

class LoginClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.85)
      ..arcToPoint(
        Offset(0, size.height * 0.85),
        radius: const Radius.elliptical(50, 10),
        rotation: 0,
      )
      ..lineTo(0, 0)
      ..close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
