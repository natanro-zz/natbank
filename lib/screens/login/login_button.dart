import 'package:flutter/material.dart';
import 'package:natbank/dao/user_dao.dart';
import 'package:natbank/screens/dashboard/dashboard.dart';
import 'package:natbank/widgets/app_dependencies.dart';
import 'package:natbank/widgets/response_dialog.dart';

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
              splashColor: Theme.of(context).primaryColor,
              color: Theme.of(context).primaryColor,
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
                          color: Theme.of(context).primaryColor,
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

      bool validate =
          await dependencies.userDAO.validate(cpf, password).catchError((e) {
        _showLoginFailureDialog(context, e.message);
      }, test: (e) => e is UserDaoException).catchError((e) {
        _showLoginFailureDialog(context, "Erro no login");
      }, test: (e) => e is Exception);
      if (validate == true) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Dashboard()));
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
