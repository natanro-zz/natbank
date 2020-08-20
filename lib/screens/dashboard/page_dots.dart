import 'package:flutter/material.dart';

class PageDots extends StatelessWidget {
  final int currentIndex;
  final double top;
  final bool showMenu;

  const PageDots({
    Key key,
    @required this.currentIndex,
    @required this.top,
    @required this.showMenu,
  }) : super(key: key);

  Color getColor(int index) {
    return index == currentIndex ? Colors.white : Colors.white38;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: showMenu ? 0.0 : 1.0,
        child: Row(
          children: <Widget>[
            AnimatedContainer(
              height: 7,
              width: 7,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: getColor(0),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            AnimatedContainer(
              height: 7,
              width: 7,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: getColor(1),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
