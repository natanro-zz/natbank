import 'package:flutter/material.dart';
import 'package:natbank/dao/user_dao.dart';
import 'package:natbank/models/response_dialog.dart';
import 'package:natbank/screens/dashboard.dart';
import 'package:natbank/screens/new_account_form.dart';
import 'package:natbank/widgets/app_dependencies.dart';

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
                  style: TextStyle(color: Colors.lightBlueAccent),
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

class LoginButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final TextEditingController cpfController;
  final TextEditingController passwordController;

  LoginButton({
    @required this.buttonText,
    @required this.buttonIcon,
    this.cpfController,
    this.passwordController,
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
                          this.buttonIcon,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: () => _validateUser(dependencies, context),
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () => _validateUser(dependencies, context),
            ),
          )
        ],
      ),
    );
  }

  Future _validateUser(
      AppDependencies dependencies, BuildContext context) async {
    {
      String cpf = cpfController.text;
      String password = passwordController.text;

      bool validate = await dependencies.userDAO
          .validate(cpf, password)
          .catchError((e) {
        _showLoginFailureDialog(context, e.message);
      }, test: (e) => e is UserDaoException)
      .catchError((e) {
        _showLoginFailureDialog(context, "Erro no login");
      }, test: (e) => e is Exception);
      if (validate == true) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Dashboard())); // TODO: alterar o push pois o Dashboard mostra uma seta para voltar para a tela de login
      }
    }
  }

  _showLoginFailureDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return FailureDialog(message: message);
        });
  }
}

class LoginInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  LoginInputField({
    @required this.icon,
    @required this.hintText,
    this.controller,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Icon(
              this.icon,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
            margin: EdgeInsets.only(left: 10, right: 10),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: this.hintText,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              controller: this.controller,
              keyboardType: this.keyboardType,
              textCapitalization: this.textCapitalization,
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
