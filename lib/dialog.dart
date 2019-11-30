import 'package:flutter/material.dart';
import 'package:tic_tac_toe/circle.dart';
import 'package:tic_tac_toe/cross.dart';
import 'package:tic_tac_toe/draw.dart';

class ResultDialog extends StatelessWidget {
  final String winner;
  final String msg;
  final Function action;
  const ResultDialog({Key key, this.winner, this.msg, this.action})
      : super(key: key);

  Widget winnerIcon() {
    if (winner == '')
      return Draw(color: Colors.yellow[300]);
    else if (winner == 'o')
      return Circle(color: Colors.green[100]);
    else
      return Cross(color: Colors.red[100]);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 10.0,
                        color: winner == 'o'
                            ? Colors.green[100]
                            : winner == 'x'
                                ? Colors.red[100]
                                : Colors.yellow[300])
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    ConstrainedBox(
                      child: winnerIcon(),
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxWidth > constraints.maxHeight
                            ? constraints.maxHeight * 0.6
                            : constraints.maxWidth,
                      ),
                    ),
                    ConstrainedBox(
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        borderSide: BorderSide(
                            color: winner == 'o'
                                ? Colors.green[100]
                                : winner == 'x'
                                    ? Colors.red[100]
                                    : Colors.yellow[300]),
                        onPressed: () {
                          action();
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Rematch'),
                      ),
                      constraints:
                          BoxConstraints(minWidth: constraints.maxWidth - 10.0),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
