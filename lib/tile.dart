import 'package:flutter/material.dart';
import 'package:tic_tac_toe/circle.dart';
import 'package:tic_tac_toe/cross.dart';

class Tile extends StatelessWidget {
  final String type;
  final Function onPressed;
  const Tile({Key key, this.type, this.onPressed}) : super(key: key);

  Color tileColor() {
    if (type == '')
      return Colors.grey[350];
    else if (type == 'o')
      return Colors.green[100];
    else
      return Colors.red[100];
  }

  Widget tileShape() {
    if (type == '')
      return Container();
    else if (type == 'o')
      return Circle(color: Colors.black);
    else
      return Cross(color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: AspectRatio(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TweenAnimationBuilder(
              tween: ColorTween(begin: Colors.white, end: tileColor()),
              duration: const Duration(milliseconds: 500),
              builder: (BuildContext context, Color value, Widget child) {
                return GestureDetector(
                  onTap: onPressed,
                  child: Container(
                      child: TweenAnimationBuilder(
                        curve: Curves.elasticInOut,
                        builder: (BuildContext context, value, Widget child) {
                          return Transform.scale(
                              scale: value, child: tileShape());
                        },
                        duration: const Duration(milliseconds: 500),
                        tween: Tween(begin: 0.0, end: type == '' ? 0.0 : 1.0),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: value,
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: value, blurRadius: 20.0)
                        ],
                      )),
                );
              },
            ),
          ),
          aspectRatio: 1.0,
        ),
      ),
    );
  }
}
