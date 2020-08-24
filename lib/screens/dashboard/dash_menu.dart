import 'package:flutter/material.dart';
import 'package:natbank/screens/dashboard/menu_item.dart';

class Menu extends StatelessWidget {
  final bool showMenu;
  final double top;

  const Menu({
    Key key,
    @required this.showMenu,
    @required this.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: showMenu ? 1.0 : 0.0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png',
                  scale: 10,
                  color: Colors.white,
                ),
                MenuTextInfo(
                  info: 'Banco ',
                  data: '- Natbank LTDA.',
                ),
                SizedBox(
                  height: 5,
                ),
                MenuTextInfo(
                  info: 'Agência ',
                  data: '0001',
                ),
                SizedBox(
                  height: 5,
                ),
                MenuTextInfo(
                  info: 'Conta ',
                  data: '00000001',
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      MenuItem(
                        icon: Icons.info_outline,
                        text: 'Me ajuda',
                      ),
                      MenuItem(
                        icon: Icons.person_outline,
                        text: 'Perfil',
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        text: 'Configurar conta',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LeaveAccountButton(),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LeaveAccountButton extends StatelessWidget {
  const LeaveAccountButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).accentColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        highlightColor: Colors.transparent,
        elevation: 0,
        disabledElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        onPressed: () {},
        child: Text(
          'SAIR DA CONTA',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}

class MenuTextInfo extends StatelessWidget {
  final String info;
  final String data;

  const MenuTextInfo({
    Key key,
    @required this.info,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: info,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: data,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
